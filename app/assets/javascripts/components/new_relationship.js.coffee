App.NewRelationshipComponent = Ember.Component.extend
  enabled: false

  _reset: (->
    if !@get('enabled')
      @set("newPerson", null)
      @set("newRelationshipName", "")
  ).observes('enabled')

  createRelationship: (person) ->
    newRelationship = @store.createRecord('relationship')
    newRelationship.set('person', person)
    newRelationship.set('contact', @get('contact'))

    newRelationship.save().then =>
      @get('contact.relationships').pushObject newRelationship
      @set('enabled', false)
      @set('newRelationship', {})
      @set("newRelationshipName", "")

  actions:
    selectPerson: (person) ->
      if person?
        @set("newPerson", null)
        @createRelationship(person)
      else
        @set("newPerson", {})
        @set("selectedPerson", null)

    saveRelationship: ->
      attributes = @get('newPerson')
      newPerson = @store.createRecord('person',
        {
          name: @get('newRelationshipName'),
          contactInfo: @get('newPerson.contactInfo'),
          role: @get('newPerson.role'),
          notes: @get('newPerson.notes')
        })

      if newPerson.isValid()
        newPerson.save().then (=>
          @createRelationship(newPerson)
        ), (=>
          @set('newPerson.errors',
            ["There was a technical error. Please try again, or contact Grezha support."])
        )
      else
        @set('newPerson.errors', newPerson.get('errors'))

