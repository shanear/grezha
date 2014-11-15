App.NewRelationshipComponent = Ember.Component.extend
  enabled: false
  autofocusRole: true
  name: Ember.computed.alias("newPerson.name")
  role: Ember.computed.alias("newPerson.role")
  contactInfo: Ember.computed.alias("newPerson.contactInfo")
  notes: Ember.computed.alias("newPerson.notes")

  _reset: (->
    if !@get('enabled')
      @set("newPerson", null)
      @set("errors", null)
      @set("newRelationshipName", "")
  ).observes('enabled')

  createRelationship: (person) ->
    newRelationship = @store.createRecord('relationship', {
        person: person
        contact: @get('contact')
      })

    newRelationship.save().then =>
      @get('contact.relationships').unshiftObject newRelationship
      @set('enabled', false)

  actions:
    selectPerson: (person) ->
      if person?
        @set("newPerson", null)
        @createRelationship(person)
      else
        @set("newPerson", {name: @get("newRelationshipName")})

    savePerson: ->
      newPerson = @store.createRecord('person', @get("newPerson"))

      if newPerson.isValid()
        newPerson.save().then (=>
          @createRelationship(newPerson)
        ), (=>
          @set('errors',
            ["There was a technical error. Please try again, or contact Grezha support."])
        )
      else
        @set('errors', newPerson.get('errors'))

    cancel: ->
      @set('enabled', false)

