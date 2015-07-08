`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`


AddedParticipantComponent = Ember.Component.extend
  tagName: 'li'
  classNames: 'added-attendee'
  participation: {}

  click: ->
    if @get("participation.isNew")
      @get('participation').deleteRecord();
    else
      @set('participation.toDelete', true)



`export default AddedParticipantComponent`