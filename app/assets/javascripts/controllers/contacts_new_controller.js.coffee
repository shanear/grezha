App.ContactsNewController = Ember.ObjectController.extend
  actions:
    createContact: ->
      newContact = @store.createRecord('contact', @get('model'))
      newContact.save().then (contact)=>
      	@transitionToRoute('contact', contact)
      	 

