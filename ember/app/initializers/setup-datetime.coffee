`import Ember from 'ember'`

# Takes two parameters: container and app
initialize = (container, app) ->
  datetime = Ember.Object.create({
    now: -> new Date()
  })

  app.register 'datetime:main', datetime, { instantiate: false }
  app.inject 'route', 'datetime', 'datetime:main'


SetupDatetimeInitializer =
  name: 'setup-datetime'
  initialize: initialize

`export {initialize}`
`export default SetupDatetimeInitializer`
