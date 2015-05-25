`import Ember from 'ember'`

EventsNewController = Ember.ObjectController.extend
  isSaving: false
  saveDisabled: Ember.computed.not('model.isValid')
  programs: []
  errors: []
  selectedProgram: null
  programName: ""

  newProgramOption: [Ember.Object.create({id: 'new', name: 'New Program'})]
  programOptions: Ember.computed.union('programs', 'newProgramOption')
  isCreatingProgram: Ember.computed 'selectedProgram', ->
    @get('selectedProgram') == 'new'

  saveProgram: ->
    if(@get('isCreatingProgram'))
      program = @store.createRecord('program', {name: @get('programName')})
      @set("model.program", program)
      program.save()
    else
      Ember.RSVP.resolve()

  actions:
    createEvent: ->
      @set('isSaving', true)

      @saveProgram().then(=>
        @get('model').save()
      ).then(
        (event)=>
          @transitionToRoute('events')
        ,(error)=>
          @set('isSaving', false)
          @set('errors', ["Something went wrong on the server, please try again later."]))


`export default EventsNewController`

