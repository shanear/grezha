`import Ember from 'ember'`

EventIndexController = Ember.ObjectController.extend
  contacts: []

  # Workaround for https://github.com/emberjs/data/issues/2666
  # Remove when fixed...
  registrations: Ember.computed.filterBy('model.registrations', 'isDeleted', false)

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

