`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`


ConfirmRegistrationComponent = Ember.Component.extend
  tagName: 'li'
  classNames: 'confirm-registration'
  classNameBindings: ['isConfirmed']
  participation: {}
  isConfirmed: Ember.computed.alias('participation.confirmed')

#  setup: Ember.on 'init', ->
#    @set('isBeingDeleted', false)

  click: ->
    @get('participation').set('confirmed', !@get('participation.confirmed'))



`export default ConfirmRegistrationComponent`