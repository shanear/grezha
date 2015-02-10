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


SetupApiConnectionInitializer =
  name: 'setup-connection'
  initialize: initialize

`export {initialize}`
`export default SetupApiConnectionInitializer`
