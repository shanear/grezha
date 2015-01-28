`import Ember from 'ember'`
`import isFeatureEnabled from '../lib/is-feature-enabled'`

ToggledFeatureComponent = Ember.Component.extend
  classNames: ['feature']
  classNameBindings: ['isEnabled:enabled:disabled']

  isEnabled: (->
    isFeatureEnabled(@get('name'), @get('session.organization'))
  ).property('name', 'session.organization')

`export default ToggledFeatureComponent`