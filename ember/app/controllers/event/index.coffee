`import Ember from 'ember'`

EventIndexController = Ember.ObjectController.extend
  contacts: []
  sortedRegistrationsBy: ['createdAt:desc']
  sortedRegistrations: Ember.computed.sort('registrations', 'sortedRegistrationsBy')

  actions:
    addRegistration: (contact)->
      newRegistration = @store.createRecord('registration', {
        event: @get('model')
        contact: contact
      })

      newRegistration.save()

`export default EventIndexController`

