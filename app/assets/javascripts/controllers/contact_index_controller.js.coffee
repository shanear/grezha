App.ContactIndexController = Ember.ObjectController.extend App.HasConfirmation,
  needs: "contacts"
  newConnection: { occurredAt: new Date(), note: "" }
  newRelationship: {}
  modes: ['In Person', 'Email', 'Phone']
  defaultMode: 'In Person'

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

    newConnection: ->
      @set('addingConnection', true)

    cancelNewConnection: ->
      @set('addingConnection', false)

    newRelationship: ->
      @set('addingRelationship', true)

    cancelNewRelationship: ->
      @set('addingRelationship', false)

    saveRelationship: ->
      newRelationship = @store.createRecord('relationship', @get('newRelationship'))
      newRelationship.set('contact', @get('model'))

      newRelationship.save().then =>
        @get('relationships').pushObject newRelationship
        @set('addingRelationship', false)
        @set('newRelationship', {})


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
        @set('errors', newConnection.get('errors'))

    changeImage: (url)->
      @set('model.pictureUrl', url)
