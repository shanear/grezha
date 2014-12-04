App.NewConnectionComponent = Ember.Component.extend
  newConnection: { occurredAt: new Date(), note: "" }
  defaultMode: 'In Person'

  actions:
    saveConnection: ->
      newConnection = @store.createRecord('connection', @get('newConnection'))
      newConnection.set('contact', @get('contact'))

      if newConnection.isValid()
        newConnection.save().then =>
          @get('contact').get('connections').pushObject newConnection

          @set('newConnection.occurredAt', new Date())
          @set('newConnection.note', "")
          @set('enabled', false)
          @set('errors', [])
      else
        @set('errors', newConnection.get('errors'))

