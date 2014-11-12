App.PersonEditController = Ember.ObjectController.extend
  needs: "contact"
  errors: []
  actions:
    savePerson: ->
      person = @get('model')
      if person.isValid()
        person.save().then(
          (person) =>
            @transitionToRoute('contact', @get("controllers.contact.model"))
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors',person.get('errors'))