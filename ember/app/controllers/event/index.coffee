`import Ember from 'ember'`

EventIndexController = Ember.ObjectController.extend
  contacts: []
  sortedRegistrationsBy: ['createdAt:desc']
  sortedRegistrations: Ember.computed.sort('registrations', 'sortedRegistrationsBy')

  actions:
    addRegistration: (contact)->
      return if @get("registrations").find((r)-> r.get('contact.id') == contact.get('id'))

      newRegistration = @store.createRecord('registration', {
        event: @get('model')
        contact: contact
      })

      newRegistration.save().catch => newRegistration.deleteRecord()

`export default EventIndexController`

