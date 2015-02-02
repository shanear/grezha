`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

ContactIndexController = Ember.ObjectController.extend HasConfirmation,
  allPeople: []

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
    newRelationship: -> @set('addingRelationship', true)
    cancelNewRelationship: -> @set('addingRelationship', false)

`export default ContactIndexController`