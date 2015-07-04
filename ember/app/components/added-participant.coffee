`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`


AddedParticipantComponent = Ember.Component.extend
  tagName: 'li'
  classNames: 'added-attendee'
  participation: {}

  click: ->
    @get('participation').deleteRecord();



`export default AddedParticipantComponent`