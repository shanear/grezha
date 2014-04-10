App.ContactsNewController = Ember.ObjectController.extend
  errors: []

  reset: ->
    @set 'errors', [""]

  actions:
    createContact: ->
      newContact = @store.createRecord('contact', @get('model'))
      if newContact.isValid() 
        newContact.save().then (contact)=>
          @transitionToRoute('contact', contact)
      else
        @set('errors', newContact.get('errors'))
        newContact.rollback()
