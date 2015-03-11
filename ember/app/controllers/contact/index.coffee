`import Ember from 'ember'`
`import Connection from 'grezha/models/connection'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

ContactIndexController = Ember.ObjectController.extend HasConfirmation,
  connectionModes: Connection.MODES
  allPeople: []
  filterByMode: null

  # Workaround for https://github.com/emberjs/data/issues/2666
  # Remove when fixed...
  relationships: Ember.computed.filterBy('model.relationships', 'isDeleted', false)

  connectionsToShow: (->
    return @get("sortedConnections") unless @get("filterByMode")?

    @get("sortedConnections").filter (connection)=>
      connection.get("mode") == @get("filterByMode")
  ).property('sortedConnections.@each.mode', 'filterByMode')

  actions:
    deleteClient: ->
      @set 'confirmation',
        heading: "Are you sure?"
        content: "Are you sure you want to delete this client? It will be gone forever!"
        show: true
        button: "Delete"
        action: =>
          @get('model').deleteRecord()
          @get('model').save()
          @transitionToRoute('contacts')

    newConnection: -> @set("addingConnection", true)
    cancelNewConnection: -> @set("addingConnection", false)
    newRelationship: -> @set('addingRelationship', true)
    cancelNewRelationship: -> @set('addingRelationship', false)
    filterMode: (mode)-> @set('filterByMode', mode)

`export default ContactIndexController`