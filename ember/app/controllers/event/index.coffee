`import Ember from 'ember'`

EventIndexController = Ember.ObjectController.extend
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

  actions:
    addRegistration: (contact)->
      return if @get("participations").find((r)-> r.get('contact.id') == contact.get('id'))

      newRegistration = @store.createRecord('participation', {
        event: @get('model')
        contact: contact
        registeredAt: new Date()
      })

      newRegistration.save().catch => newRegistration.deleteRecord()

`export default EventIndexController`

