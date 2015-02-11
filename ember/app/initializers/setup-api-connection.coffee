`import Ember from 'ember'`

# Takes two parameters: container and app
initialize = (container, app) ->
  apiConnection = Ember.Object.create({
    online: true
  })

  app.register 'api-connection:main', apiConnection, { instantiate: false }
  app.inject 'controller', 'apiConnection', 'api-connection:main'
  app.inject 'component', 'apiConnection', 'api-connection:main'
  app.inject 'adapter', 'apiConnection', 'api-connection:main'

  adapter = container.lookup('adapter:application')
  adapter.syncRecords()
  setInterval (->
    ping = Ember.$.get(EmberENV.apiURL + '/api/ping')
    ping.fail => apiConnection.set('online', false)
    ping.done =>
      if apiConnection.get('online') == false
        apiConnection.set('online', true)
        adapter.syncRecords()
  ), 10000

SetupApiConnectionInitializer =
  name: 'setup-connection'
  after: "store"
  initialize: initialize

`export {initialize}`
`export default SetupApiConnectionInitializer`
