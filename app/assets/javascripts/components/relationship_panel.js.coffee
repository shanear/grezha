App.RelationshipPanelComponent = Ember.Component.extend App.HasConfirmation,
  relationship: {}

  actions:
    deleteRelationship: ->
      @set 'confirmation',
        heading: "Are you sure?"
        content: "Are you sure you want to delete this relationship? It will be gone forever!"
        show: true
        button: "Delete"
        action: =>
          @get('relationship.contact.relationships').removeObject @get('relationship')
          @get('relationship').deleteRecord()
          @get('relationship').save()
