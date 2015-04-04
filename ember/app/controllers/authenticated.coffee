`import Ember from 'ember'`
`import config from '../config/environment'`

AuthenticatedController = Ember.Controller.extend
  needs: ['contacts']
  environment: config.environment
  isProduction: (config.environment == 'production')
  adminURL: EmberENV.adminURL
  allContacts: Ember.computed.alias('controllers.contacts.all')
  isMenuShowing: false

  reset: ->
    @set("isMenuShowing", false)
    @set("isSearchShowing", false)

  actions:
    toggleMenu: ->
      @set("isSearchShowing", false)
      @set("isMenuShowing", !@get("isMenuShowing"))

`export default AuthenticatedController`