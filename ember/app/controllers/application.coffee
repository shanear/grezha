`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  environment: config.environment
  isProduction: (config.environment == 'production')
  adminURL: EmberENV.adminURL
  allContacts: []
  actions:
    toggleSupport: ->
      @set("supportActive", !@get("supportActive"))

`export default ApplicationController`