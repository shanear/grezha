`import Ember from 'ember'`

EventLogController = Ember.ObjectController.extend
  contacts: []

  # Workaround for https://github.com/emberjs/data/issues/2666
  # Remove when fixed...
  participations: Ember.computed.filterBy('model.participations', 'isDeleted', false)
  sortParticipationsBy: ['name:desc']
  sortedParticipations: Ember.computed.sort('participations', 'sortParticipationsBy')
  confirmedParticipations: Ember.computed.filterBy('participations', 'confirmed', true)

  registrations: Ember.computed.filterBy('sortedParticipations', 'isRegistered', true)
  unconfirmedRegistrations: Ember.computed.filterBy('registrations', 'confirmed', false)
  additionalParticipants: Ember.computed.filterBy('sortedParticipations', 'isRegistered', false)

  actions:
    saveLog: ->
      savedParticipations = @get('confirmedParticipations').map (participation)->
        participation.set("confirmedAt", new Date())
        participation.save()
      @get('model').save()

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

