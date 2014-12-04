App.PersonEditController = Ember.ObjectController.extend
  autofocusName: true
  needs: "contact"
  errors: []
  contact: Ember.computed.alias("controllers.contact.model")

  reset: ->
    @set('errors', [])

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

    cancel: ->
      @transitionToRoute('contact', @get("contact"))