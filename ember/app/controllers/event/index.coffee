`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

EventIndexController = Ember.ObjectController.extend HasConfirmation,
  contacts: []

  # Workaround for https://github.com/emberjs/data/issues/2666
  # Remove when fixed...
  participations: Ember.computed.filterBy('model.participations', 'isDeleted', false)

  sortedRegistrationsBy: ['registeredAt:desc']
  sortedRegistrations: Ember.computed.sort('participations', 'sortedRegistrationsBy')

  sortParticipationsBy: ['name:desc']
  sortedParticipations: Ember.computed.sort('participations', 'sortParticipationsBy')
  confirmedParticipations: Ember.computed.filterBy('sortedParticipations', 'isConfirmed', true)

  totalAttendeeCount: Ember.computed 'model.otherAttendeeCount', 'confirmedParticipations.[]', ->
    @get('confirmedParticipations.length') + (@get('model.otherAttendeeCount') || 0)

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

    addRegistration: (contact)->
      return if @get("participations").find((r)-> r.get('contact.id') == contact.get('id'))

      newRegistration = @store.createRecord('participation', {
        event: @get('model')
        contact: contact
        registeredAt: new Date()
      })

      newRegistration.save().catch => newRegistration.deleteRecord()

`export default EventIndexController`

