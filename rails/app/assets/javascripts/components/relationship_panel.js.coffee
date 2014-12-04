App.RelationshipPanelComponent = Ember.Component.extend App.HasConfirmation,
  relationship: {}

  actions:
    deleteRelationship: ->
      @get('relationship.contact.relationships').removeObject @get('relationship')
      @get('relationship').deleteRecord()
      @get('relationship').save()
