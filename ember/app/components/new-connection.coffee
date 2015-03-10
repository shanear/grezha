`import Ember from 'ember'`
`import Connection from 'grezha/models/connection'`

NewConnectionComponent = Ember.Component.extend
  newConnection: { occurredAt: new Date(), note: "" }
  defaultMode: 'In Person'
  connectionModes: Connection.MODES
  isSaving: false

  actions:
    saveConnection: ->
      newConnection = @store.createRecord('connection', @get('newConnection'))
      newConnection.set('contact', @get('contact'))

      if newConnection.isValid()
        @set("isSaving", true)
        newConnection.save().then =>
          @get('contact').get('connections').pushObject newConnection

          @set('newConnection.occurredAt', new Date())
          @set('newConnection.note', "")
          @set('enabled', false)
          @set('errors', [])
          @set("isSaving", false)
      else
        @set('errors', newConnection.get('errors'))

`export default NewConnectionComponent`
