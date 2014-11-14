App.ContactsNewController = Ember.ObjectController.extend
  errors: []
  reset: -> @set 'errors', []

  actions:
    createContact: ->
      newContact = @store.createRecord('contact', @get('model'))
      if newContact.isValid()
        newContact.save().then(
          (contact)=>
            @transitionToRoute('contact', contact)
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors', newContact.get('errors'))
        newContact.destroyRecord();

