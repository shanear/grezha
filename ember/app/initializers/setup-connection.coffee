`import Ember from 'ember'`

# Takes two parameters: container and app
initialize = (container, app) ->
  connection = Ember.Object.create({
    online: true
  })

  app.register 'connection:main', connection, { instantiate: false }
  app.inject 'controller', 'connection', 'connection:main'
  app.inject 'component', 'connection', 'connection:main'


SetupConnectionInitializer =
  name: 'setup-connection'
  initialize: initialize

`export {initialize}`
`export default SetupConnectionInitializer`
