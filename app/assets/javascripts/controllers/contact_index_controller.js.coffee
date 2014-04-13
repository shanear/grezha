App.ContactIndexController = Ember.ObjectController.extend App.HasConfirmation,
  needs: "contacts"
  newConnection: { occurredAt: new Date(), note: "" }

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

    saveConnection: ->
      return if !@get('newConnection.note')

      newConnection = @store.createRecord('connection',
        @get('newConnection'))
      newConnection.set('contact', @get('model'))

      newConnection.save().then =>
        @set('newConnection.occurredAt', new Date())
        @set('newConnection.note', "")
        @set('addingConnection', false)

    changeImage: (url)->
      @set('model.pictureUrl', url)
