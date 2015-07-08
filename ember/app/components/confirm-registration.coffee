`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`


ConfirmRegistrationComponent = Ember.Component.extend
  tagName: 'li'
  classNames: 'confirm-registration'
  classNameBindings: ['isConfirmed']
  participation: {}
  isConfirmed: Ember.computed.alias('participation.isConfirmed')

  click: ->
    @get('participation').set("confirmedAt",
      if @get('participation.isConfirmed') then null else new Date())



`export default ConfirmRegistrationComponent`