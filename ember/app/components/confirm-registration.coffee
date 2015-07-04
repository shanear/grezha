`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`


ConfirmRegistrationComponent = Ember.Component.extend
  tagName: 'li'
  classNames: 'confirm-registration'
  classNameBindings: ['isConfirmed']
  participation: {}
  isConfirmed: Ember.computed.alias('participation.confirmed')

  click: ->
    @get('participation').set('confirmed', !@get('participation.confirmed'))



`export default ConfirmRegistrationComponent`