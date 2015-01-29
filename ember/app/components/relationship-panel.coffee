`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

RelationshipPanelComponent = Ember.Component.extend HasConfirmation,
  relationship: {}

  actions:
    deleteRelationship: ->
      @get('relationship.contact.relationships').removeObject @get('relationship')
      @get('relationship').deleteRecord()
      @get('relationship').save()

`export default RelationshipPanelComponent`