`import Ember from 'ember'`

EventsNewController = Ember.ObjectController.extend
  isSaving: false
  saveDisabled: Ember.computed.not('model.isValid')
  errors: []

  actions:
    createEvent: ->
      newEvent = @store.createRecord('event', @get('model'))

      @set('isSaving', true)
      newEvent.save().then(
        (event)=>
          @transitionToRoute('events')
        ,(error)=>
          @store.unloadRecord(newEvent)
          @set('isSaving', false)
          @set('errors', ["Something went wrong on the server, please try again later."]))


`export default EventsNewController`

