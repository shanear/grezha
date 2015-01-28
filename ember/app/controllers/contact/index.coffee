`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

ContactIndexController = Ember.ObjectController.extend HasConfirmation,
  needs: ['application']
  isReadonly: Ember.computed.oneWay('controllers.application.isReadonly')

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

`export default ContactIndexController`