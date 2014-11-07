App.ContactIndexController = Ember.ObjectController.extend App.HasConfirmation,
  needs: "contacts"
  newRelationship: {}
  allRelationships: []

  actions:
    autofillRelationshipForm: (relationship) ->
      @set("newRelationship.contactInfo", relationship.get("contactInfo"))
      @set("newRelationship.relationshipType", relationship.get("relationshipType"))
      @set("newRelationship.notes", relationship.get("notes"))

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

    saveRelationship: ->
      newRelationship = @store.createRecord('relationship', @get('newRelationship'))
      newRelationship.set('contact', @get('model'))

      if newRelationship.isValid()
        newRelationship.save().then =>
          @get('relationships').pushObject newRelationship
          @set('addingRelationship', false)
          @set('newRelationship', {})

      else
        @set('relationshipErrors', newRelationship.get('errors'))

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

