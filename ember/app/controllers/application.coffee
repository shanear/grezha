`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  needs: ['contacts']
  environment: config.environment
  isProduction: (config.environment == 'production')
  adminURL: EmberENV.adminURL
  allContacts: Ember.computed.alias('controllers.contacts.model')
  actions:
    toggleSupport: ->
      @set("supportActive", !@get("supportActive"))

`export default ApplicationController`