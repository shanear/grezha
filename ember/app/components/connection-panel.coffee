`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

ConnectionPanelComponent = Ember.Component.extend HasConfirmation,
  connection: {}

  actions:
    deleteConnection: ->
      @set 'confirmation',
        heading: "Are you sure?"
        content: "Are you sure you want to delete this connection? It will be gone forever!"
        show: true
        button: "Delete"
        action: =>
          @get('connection.contact.connections').removeObject @get('connection')
          @get('connection').deleteRecord()
          @get('connection').save()

`export default ConnectionPanelComponent`