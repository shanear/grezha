App.ContactIndexController = Ember.ObjectController.extend App.HasConfirmation,
  needs: "contacts"
  newRelationship: {}
  relationships: []
  highlightedRelationshipIndex: -1
  selectedName: ""
  isAutocompleting: (->
    @get('newRelationship.name') && @get('newRelationship.name') != @get('selectedName')
  ).property("newRelationship.name", "selectedName")

  autocompleteRelationships: (->
    query = @get("newRelationship.name") || ""
    @relationships.filter (relationship)->
      relationship.get('name').toUpperCase().substring(0,query.length) == query.toUpperCase()
  ).property('newRelationship.name')

  resetHighlightedRelationship: (->
    @setHighlightedRelationship(-1)
  ).observes('newRelationship.name')

  setHighlightedRelationship: (index)->
    @get("autocompleteRelationships").forEach (relationship)->
      relationship.set("isHighlighted", false)

    newHighlightedRelationship = @get("autocompleteRelationships").objectAt(index)

    @set("highlightedRelationshipIndex", index)
    newHighlightedRelationship.set("isHighlighted", true) if newHighlightedRelationship

  actions:
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

    highlightAutocomplete: (relationship)->
      index = @get('autocompleteRelationships').indexOf(relationship)
      console.log(index)
      @setHighlightedRelationship(index)

    autocomplete: (relationship)->
      if relationship?
        relationship = @get("autocompleteRelationships").objectAt(@get("highlightedRelationshipIndex"))

      if relationship?
        @set("selectedName", relationship.get("name"))
        @set("newRelationship.name", relationship.get("name"))
        @set("newRelationship.contactInfo", relationship.get("contactInfo"))
        @set("newRelationship.relationshipType", relationship.get("relationshipType"))
        @set("newRelationship.notes", relationship.get("notes"))

    moveAutocompleteHighlightDown: ->
      if(@get("highlightedRelationshipIndex") + 1 < @get("autocompleteRelationships.length"))
        newIndex = @get("highlightedRelationshipIndex") + 1
        @setHighlightedRelationship(newIndex)

    moveAutocompleteHighlightUp: ->
      if(@get("highlightedRelationshipIndex") > -1)
        newIndex = @get("highlightedRelationshipIndex") - 1
        @setHighlightedRelationship(newIndex)
