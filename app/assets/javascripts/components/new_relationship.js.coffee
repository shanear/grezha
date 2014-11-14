App.NewRelationshipComponent = Ember.Component.extend
  enabled: false

  _reset: (->
    if !@get('enabled')
      @set("newPerson", null)
      @set("newRelationshipName", "")
  ).observes('enabled')

  createRelationship: (person) ->
    newRelationship = @store.createRecord('relationship', {
        person: person
        contact: @get('contact')
      })

    newRelationship.save().then =>
      @get('contact.relationships').pushObject newRelationship
      @set('enabled', false)

  actions:
    selectPerson: (person) ->
      if person?
        @set("newPerson", null)
        @createRelationship(person)
      else
        @set("newPerson", {})
        Ember.Binding.from("newRelationshipName")
                     .to("newPerson.name").connect(this)

    saveRelationship: ->
      newPerson = @store.createRecord('person', @get("newPerson"))

      if newPerson.isValid()
        newPerson.save().then (=>
          @createRelationship(newPerson)
        ), (=>
          @set('newPerson.errors',
            ["There was a technical error. Please try again, or contact Grezha support."])
        )
      else
        @set('newPerson.errors', newPerson.get('errors'))

