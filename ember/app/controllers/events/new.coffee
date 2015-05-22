`import Ember from 'ember'`

EventsNewController = Ember.ObjectController.extend
  isSaving: false
  saveDisabled: Ember.computed.not('model.isValid')
  programs: []
  errors: []

  actions:
    createEvent: ->
      @set('isSaving', true)
      @get('model').save().then(
        (event)=>
          @transitionToRoute('events')
        ,(error)=>
          @set('isSaving', false)
          @set('errors', ["Something went wrong on the server, please try again later."]))


`export default EventsNewController`

