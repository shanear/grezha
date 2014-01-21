App.ContactsNewController = Ember.ObjectController.extend
  actions:
    createContact: ->
      @store.createRecord 'contact', @get('model')
