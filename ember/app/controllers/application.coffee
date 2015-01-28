`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  isOnline: true
  environment: config.environment
  isProduction: (config.environment == 'production')
  isReadonly: Ember.computed.not('isOnline')

`export default ApplicationController`