App.ContactEditController = Ember.ObjectController.extend
  errors: []
  allUsers: []

  reset: ->
    @set('errors', [])

  actions:
    saveContact: ->
      contact = @get('model')
      if contact.isValid()
        contact.save().then(
          (contact)=>
            @transitionToRoute('contact', contact)
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors',contact.get('errors'))
