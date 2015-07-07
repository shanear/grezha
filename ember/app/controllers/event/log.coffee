`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

EventLogController = Ember.ObjectController.extend HasConfirmation,
  contacts: []
  isSaving: false

  # Workaround for https://github.com/emberjs/data/issues/2666
  # Remove when fixed...
  participations: Ember.computed.filterBy('model.participations', 'isDeleted', false)
  sortParticipationsBy: ['name:desc']
  sortedParticipations: Ember.computed.sort('participations', 'sortParticipationsBy')
  confirmedParticipations: Ember.computed.filterBy('participations', 'confirmed', true)

  registrations: Ember.computed.filterBy('sortedParticipations', 'isRegistered', true)
  unconfirmedRegistrations: Ember.computed.filterBy('registrations', 'confirmed', false)
  additionalParticipants: Ember.computed.filterBy('sortedParticipations', 'isRegistered', false)

  confirmDeleteEvent: ->
    @transitionToRoute('events', {
      programFilter: null,
      status: (if @get('model.isUpcoming') then 'upcoming' else 'past')
    })
    @get('model.participations').forEach (p)-> p.deleteRecord();
    @get('model').deleteRecord()
    @get('model').save()

  actions:
    deleteEvent: ->
      @set 'confirmation',
        heading: "Are you sure?"
        content: "Are you sure you want to delete this event? It will be gone forever!"
        show: true
        button: "Delete"
        action: => @confirmDeleteEvent()

    saveLog: ->
      @set('isSaving', true)
      savedParticipations = @get('confirmedParticipations').map (participation)->
        participation.set("confirmedAt", new Date())
        participation.save()
      @set('model.loggedAt', new Date())
      @get('model').save().then =>
        @transitionToRoute('event', @get('model'))

    everybodyAttended: ->
      @get('registrations').forEach (participation)->
        participation.set('confirmed', true)

    addParticipant: (contact)->
      return if @get("participations").find((r)-> r.get('contact.id') == contact.get('id'))

      newParticipant = @store.createRecord('participation', {
        event: @get('model')
        contact: contact
        confirmed: true
      })

`export default EventLogController`

