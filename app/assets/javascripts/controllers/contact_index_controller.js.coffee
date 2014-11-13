App.ContactIndexController = Ember.ObjectController.extend App.HasConfirmation,
  needs: "contacts"
  allPeople: []

  createRelationship: (person) ->
    newRelationship = @store.createRecord(
      'relationship')
    newRelationship.set('person', person)
    newRelationship.set('contact', @get('model'))

    newRelationship.save().then =>
      @get('relationships').pushObject newRelationship
      @set('addingRelationship', false)
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

    deleteContact: ->
      @set 'confirmation',
        heading: "Are you sure?"
        content: "Are you sure you want to delete this contact? It will be gone forever!"
        show: true
        button: "Delete"
        action: =>
          @get('model').deleteRecord()
          @get('model').save()
          @transitionToRoute('contacts')

    newRelationship: ->
      @set('addingRelationship', true)

    cancelNewRelationship: ->
      @set('addingRelationship', false)
      @set("selectedPerson", null)
      @set("newPerson", null)
      @set("newRelationshipName", "")

    saveRelationship: ->
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

    saveConnection: ->
      newConnection = @store.createRecord('connection', @get('newConnection'))
      newConnection.set('contact', @get('model'))

      if newConnection.isValid()
        newConnection.save().then =>
          @get('connections').pushObject newConnection

          @set('newConnection.occurredAt', new Date())
          @set('newConnection.note', "")
          @set('addingConnection', false)
      else
        @set('connectionErrors', newConnection.get('errors'))

    changeImage: (url)->
      @set('model.pictureUrl', url)

