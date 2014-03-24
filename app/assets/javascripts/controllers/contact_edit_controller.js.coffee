App.ContactEditController = Ember.ObjectController.extend

  errors: []

  actions:

    saveContact: ->
      contact = @get('model')
      if contact.isValid()
        contact.save().then (contact)=>
          @transitionToRoute('contact', contact)
      else 
        @set('errors',contact.get('errors'))
