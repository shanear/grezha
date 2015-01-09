`import Ember from 'ember'`

ToggledFeatureComponent = Ember.Component.extend
  classNames: ['feature']
  classNameBindings: ['isEnabled:enabled:disabled']

  isEnabled: (->
    organization = @get('session.organization')

    return true if organization == 'Grezha Admin'

    if @get('name') == 'vehicles'
      if organization == 'Daughters of Bulgaria'
        return true

    if @get('name') == 'addedOn'
      if organization == 'Contra Costa Reentry Network'
        return true

    return false
  ).property('name', 'session.organization')

`export default ToggledFeatureComponent`