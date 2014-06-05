Application = Ember.Application.extend
  online: true
  readonly: Ember.computed.not('online')
  loggedIn: (-> $.cookie('remember_token') != undefined).property()

Application.initializer
  name: "start connectivity checks"
  after: "store"
  initialize: (container, application)->
    store = container.lookup('store:main')

    checkConnection = ->
      ping = Ember.$.get('/ping')
      ping.fail -> application.set('online', false)

      ping.done ->
        if application.get('online') == false
          application.set('online', true)
          store.syncRecords()

    store.syncRecords()
    checkConnection()
    setInterval checkConnection, 10000


Application.initializer
  name: "configuration"
  initialize: (container, application)->
    env = EmberConfiguration.environment
    application.set('environment', env)
    application.set('isProduction', (env == "production"))
    application.set('isDemo', (env == "demo"))
    application.set('currentUser', EmberConfiguration.currentUser)


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
  rootElement: EmberConfiguration.rootElement

