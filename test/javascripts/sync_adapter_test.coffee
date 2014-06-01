window.stubGet = (url, json, code = 200)->
  server.get url, ->
    result = JSON.stringify(json)
    return [code, {"Content-Type" : "application/json"}, result]

App.initializer
  name: "clear outstanding changes"
  before: "start connectivity checks"
  initialize: -> localforage.setItem("changes", [])

module "SyncAdapter",
  setup: ->
    window.Client = DS.Model.extend
      name: DS.attr('string'),
      unsyncedChanges: DS.attr('number')

    adapter = App.SyncAdapter.extend
      namespace: ""
      databaseName: 'grezhatest'
      featuresEnabled: 'edge'

    container = new Ember.Container()
    container.register 'store:main', DS.Store.extend(adapter: adapter)
    container.register 'serializer:application', DS.ActiveModelSerializer
    container.register 'model:client', Client

    window.store = container.lookup 'store:main'

    transforms = {
      'boolean': DS.BooleanTransform.create(),
      'date': DS.DateTransform.create(),
      'number': DS.NumberTransform.create(),
      'string': DS.StringTransform.create()
    }

    DS.ActiveModelSerializer.reopen({
      transformFor: (attributeType)->
        @_super(attributeType, true) || transforms[attributeType];
    })

    window.server = new Pretender()


asyncTest "Stores records in localforage for offline", ->
  expect(2)

  setupStep = new Ember.RSVP.Promise (resolve, reject)->
    localforage.clear -> resolve()

  offlineTestStep = setupStep.then ->
    stubGet "/clients", {}, 404
    Ember.run ->
      store.find('client').then ->
        ok(false, "Find should fail when API unavailable")
        start()

  onlineTestStep = offlineTestStep.finally ->
    stubGet "/clients", { clients: [{id: 1, name: "Shane Train"}] }, 200
    Ember.run ->
      store.find('client').then (result)->
        clients = result.toArray()
        equal(clients.get('length'), 1, "Records should be returned from the API")

  cachedTestStep = onlineTestStep.finally ->
    stubGet "/clients", {}, 404
    Ember.run ->
      findClients = store.find('client')

      findClients.then (result)->
        clients = result.toArray()
        equal(clients.get('length'), 1, "Records should be cached correctly")
        start()

      findClients.catch ->
        ok(false, "Find should succeed when records are cached")
        start()


asyncTest "Records added while offline are saved in localforage", ->
  expect(5)

  # Setup a base local storage of 0 clients
  setupStep = new Ember.RSVP.Promise (resolve, reject)->
    localforage.clear ->
      stubGet "/clients", { clients: [] }, 200
      store.find('client').then -> resolve()

  saveOfflineStep = setupStep.then ->
    Ember.run ->
      client = store.createRecord('client', {name: 'something'})
      clientSave = client.save()

      clientSave.then ->
        clientId = client.get("id")

        stubGet "/clients", {}, 404
        store.unloadAll('client')

        store.find('client', clientId).then (fetchedClient)->
          equal(fetchedClient.get('id'), clientId,
              "Cached record id should match saved record")
          equal(fetchedClient.get('name'), 'something',
              "Cached record attribute should match saved record")
          equal(fetchedClient.get('isRemoteSynced'), false,
              "Locally stored record shouldn't be marked as synced")

      clientSave.catch (error)->
        ok(false, "Record should save successfully while offline")

  syncOnlineStep = saveOfflineStep.then ->
    server.post "/clients", (request)->
      ok(true, "Record should be synced online")
      [200, {"Content-Type" : "application/json"}, request.requestBody]

    store.syncRecords().then ->
      store.find('client').then (result)->
        client = result.toArray()[0]
        equal(client.get('isRemoteSynced'), true, "Added client should be marked as synced")
        start()


asyncTest "Records added while online are saved online and cached offline", ->
  expect(3)

  # Setup a base local storage of 0 clients
  setupStep = new Ember.RSVP.Promise (resolve, reject)->
    localforage.clear ->
      stubGet "/clients", { clients: [] }, 200
      store.find('client').then -> resolve()

  saveOnlineStep = setupStep.then ->
    server.post "/clients", (request)->
      ok(true, "Record should save online")
      response = JSON.parse(request.requestBody)
      response["client"]["name"] = "New Name"
      [200, {"Content-Type" : "application/json"}, JSON.stringify(response)]

    Ember.run ->
      client = store.createRecord('client', {name: "something"})

      client.save().then ->
        stubGet "/clients", {}, 404
        store.unloadAll('client')

        findClients = store.find('client')

        findClients.then (result)->
          clients = result.toArray()
          equal(clients.get('length'), 1, "Records should be saved offline and online")
          equal(clients[0].get('name'), "New Name", "Record should retain values given from server")
          start()

        findClients.catch ->
          ok(false, "Records should be saved offline and online")
          start()


asyncTest "Fetched records combine with locally added records", ->

  setupStep = new Ember.RSVP.Promise (resolve, reject)->
    localforage.clear ->
      stubGet "/clients", { clients: [] }, 200
      store.find('client').then (clients)-> resolve()

  saveOfflineStep = setupStep.then ->
    stubGet "/clients", {}, 404
    Ember.run ->
      client = store.createRecord('client', {name: 'Tina Fey'})
      client.save()

  fetchOnlineStep = saveOfflineStep.then ->
    stubGet "/clients", { clients: [{id: 11, name: "Liz Lemon"}] }, 200
    store.unloadAll('client')

    findClients = store.find('client')

    findClients.then (result)->
      clients = result.toArray()
      equal(clients.get('length'), 2, "Unsaved records should not be overwritten when online syncing")
      start()

    findClients.catch ->
      ok(false, "Online fetch should work after saving records locally")
      start()
