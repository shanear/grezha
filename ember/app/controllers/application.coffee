`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  needs: ['contacts']
  environment: config.environment
  isProduction: (config.environment == 'production')
  adminURL: EmberENV.adminURL
  allContacts: Ember.computed.alias('controllers.contacts.model')
  isMenuShowing: false

  reset: ->
    @set("isMenuShowing", false)
    @set("isSearchShowing", false)

  actions:
    toggleSupport: ->
      @set("supportActive", !@get("supportActive"))

    toggleMenu: ->
      @set("isSearchShowing", false)
      @set("isMenuShowing", !@get("isMenuShowing"))

    toggleSearch: ->
      @set("isMenuShowing", false)
      @set("isSearchShowing", !@get("isSearchShowing"))
      true

`export default ApplicationController`