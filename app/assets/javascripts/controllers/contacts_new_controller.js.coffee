App.ContactsNewController = Ember.ObjectController.extend
  errors: []

  isContactUnique: (contact)->
    contacts = @store.all('contact')
    i = 0
    while i < contacts.get('length')
      if(contacts.objectAt(i).get('name') == contact.get('name'))
        @set('errors', ["That name already exists."])
        console.log('there be errors')
        return false
      i++
    return true
    

  actions:
    createContact: ->
      @set('errors', [])
      newContact = @store.createRecord('contact', @get('model'))
      if newContact.isValid() and @isContactUnique(newContact)
        newContact.save().then (contact)=>
          @transitionToRoute('contact', contact)
      else
        @errors.push.apply(@errors, newContact.get('errors'))
        newContact.rollback()
