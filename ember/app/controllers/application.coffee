`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  environment: config.environment
  isProduction: (config.environment == 'production')
  allContacts: []

`export default ApplicationController`