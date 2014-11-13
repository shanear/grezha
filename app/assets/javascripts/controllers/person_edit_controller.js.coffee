App.PersonEditController = Ember.ObjectController.extend
  needs: "contact"
  errors: []
  contact: Ember.computed.alias("controllers.contact.model")
  actions:
    savePerson: ->
      person = @get('model')
      if person.isValid()
        person.save().then(
          (person) =>
            @transitionToRoute('contact', @get("contact"))
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors',person.get('errors'))