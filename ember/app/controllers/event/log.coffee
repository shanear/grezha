`import Ember from 'ember'`

EventLogController = Ember.ObjectController.extend
  contacts: []

  # Workaround for https://github.com/emberjs/data/issues/2666
  # Remove when fixed...
  participations: Ember.computed.filterBy('model.participations', 'isDeleted', false)
  sortedRegistrationsBy: ['name:desc']
  sortedRegistrations: Ember.computed.sort('participations', 'sortedRegistrationsBy')

  actions:
    addAttendee: (contact)->
      return if @get("participations").find((r)-> r.get('contact.id') == contact.get('id'))

      newRegistration = @store.createRecord('participation', {
        event: @get('model')
        contact: contact
        registeredAt: new Date()
      })

      #newRegistration.save().catch => newRegistration.deleteRecord()

`export default EventLogController`

