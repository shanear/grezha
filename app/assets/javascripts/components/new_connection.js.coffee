App.NewConnectionComponent = Ember.Component.extend
  newConnection: { occurredAt: new Date(), note: "" }
  modes: ['In Person', 'Email', 'Phone']
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
      else
        @set('errors', newConnection.get('errors'))

