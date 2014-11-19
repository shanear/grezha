Application = Ember.Application.extend
  online: true
  readonly: Ember.computed.not('online')
  loggedIn: (-> $.cookie('remember_token') != undefined).property()

  setAlert: (text)->
    @set('alertText', text);
    setTimeout (=> @set('alertText', null) ), 5000

  _checkConnection: (->
    if @get("checkConnection")
      ping = Ember.$.get('/ping')
      ping.fail => @set('online', false)
      ping.done =>
        if @get('online') == false
          @set('online', true)
          @get("store").syncRecords()

      @set("checkConnection", false)
  ).observes("checkConnection")


Application.initializer
  name: "start connectivity checks"
  after: "store"
  initialize: (container, application)->
    store = container.lookup('store:main')
    store.syncRecords()
    setInterval (->
      application.set("checkConnection", true)
    ), 10000


Application.initializer
  name: 'inject store',
  after: "store"
  initialize: (container, application)->
    application.set("store", container.lookup('store:main'))


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
      return true if App.organizationId == '2' || App.organization == 'Grezha Admin'
      return true if featureName == 'vehicles' && (App.organizationId == '1' || App.organization == 'Daughters of Bulgaria')
      return true if featureName == 'memberId' && (App.organizationId == '3' || App.organization == 'Contra Costa Reentry Network')
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
