Application = Ember.Application.extend
  state: 'up'
  online: true
  readonly: Ember.computed.not('online')

Application.initializer
  name: "start connectivity checks"
  initialize: (container, application)->
    setInterval (->
      ping = Ember.$.get('/ping')
      ping.done -> application.set('online', true)
      ping.fail -> application.set('online', false)
    ), 10000

# Load (and cache) all primary models on application load
### This is experimental, don't do it for now
Application.initializer
  name: "preload"
  after: "store"
  initialize: (container, application)->
    store = container.lookup("store:main")
    store.all(App.Contact)
    store.all(App.Vehicle)
###

window.App = Application.create
  rootElement: '#ember-app'

