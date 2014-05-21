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


asyncTest "finds records from api", ->
  stubGet "/clients", { clients: [{id: 1, name: "Shane Train"}] }

  Ember.run ->
    store.find('client').then (clients)->
      equal(clients.get('length'), 1, "One client should be returned from the API")
      start()