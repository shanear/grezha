App.ContactIndexController = Ember.ObjectController.extend App.HasConfirmation,
  needs: "contacts"
  allPeople: []

  connectionsByMode: (->
    connectByMode = @get('connections').reduce ((modeTypes, connection) ->
      if modeTypes[connection.get('mode')]?
        modeTypes[connection.get('mode')].pushObject(connection)
      else
        modeTypes[connection.get('mode')] = [connection]
      modeTypes
    ), {}
    connectByModeAsArray = []
    for mode of connectByMode
      connectByModeAsArray.push
        mode : mode
        connections: connectByMode[mode]
    connectByModeAsArray
  ).property('connections.@each')

  reset: ->
    @set('addingRelationship', false)
    @set('addingConnection', false)

  actions:
    deleteContact: ->
      @set 'confirmation',
        heading: "Are you sure?"
        content: "Are you sure you want to delete this contact? It will be gone forever!"
        show: true
        button: "Delete"
        action: =>
          @get('contact').deleteRecord()
          @get('contact').save()
          @transitionToRoute('contacts')

    newConnection: -> @set("addingConnection", true)
    cancelNewConnection: -> @set("addingConnection", false)
    newRelationship: -> @set('addingRelationship', true)
    cancelNewRelationship: -> @set('addingRelationship', false)

    changeImage: (url)->
      @set('model.pictureUrl', url)

