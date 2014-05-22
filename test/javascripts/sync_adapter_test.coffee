window.stubGet = (url, json, code = 200)->
  server.get url, ->
    result = JSON.stringify(json)
    return [code, {"Content-Type" : "application/json"}, result]

module "SyncAdapter",
  setup: ->
    window.Client = DS.Model.extend
      name: DS.attr('string')

    adapter = App.SyncAdapter.extend
      namespace: ""
      databaseName: 'grezhatest'

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

    stop()
    localforage.clear -> start()


asyncTest "Stores records in localstorage for offline", ->
  offlineClients = onlineClients = null
  expect(2)

  stubGet "/clients", {}, 404
  Ember.run ->
    offlineClients = store.find('client').then ->
      ok(false, "Find should fail when API unavailable")

  offlineClients.finally ->
    stubGet "/clients", { clients: [{id: 1, name: "Shane Train"}] }, 200
    Ember.run ->
      onlineClients = store.find('client')
      onlineClients.then ->
        equal(onlineClients.get('length'), 1, "Records should be returned from the API")

    onlineClients.then ->
      stubGet "/clients", {}, 404
      Ember.run ->
        cachedClients = store.find('client')
        cachedClients.then ->
          equal(cachedClients.get('length'), 1, "Records should be cached correctly")

        cachedClients.catch ->
          ok(false, "Find should succeed when records are cached")

        cachedClients.finally ->
          start()
