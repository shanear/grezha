Application = Ember.Application.extend
  online: true
  readonly: Ember.computed.not('online')
  loggedIn: (-> $.cookie('remember_token') != undefined).property()

  setAlert: (text)->
    @set('alertText', text);
    setTimeout (=> @set('alertText', null) ), 5000

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
    application.set('organization', EmberConfiguration.organization)
    application.set('organizationId', EmberConfiguration.organizationId)
    application.set('isAdmin', EmberConfiguration.isAdmin)

    application.set('hasFeature', (featureName)->
      return true if App.organizationId == '2'
      return true if featureName == 'vehicles' && App.organizationId == '1'
      return true if featureName == 'memberId' && App.organizationId == '3'
      return false
    )

    if EmberConfiguration.alert
      application.setAlert(EmberConfiguration.alert)


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

