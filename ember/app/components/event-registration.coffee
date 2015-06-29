`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`


EventRegistrationComponent = Ember.Component.extend
  tagName: 'li'
  participation: {}
  isBeingDeleted: false

  setup: Ember.on 'init', ->
    @set('isBeingDeleted', false)

  actions:
    deleteRegistration: (participation)-> @set("isBeingDeleted", true)
    cancelDeleteRegistration: -> @set('isBeingDeleted', false)
    confirmDeleteRegistration: ->
      @get('participation').destroyRecord()



`export default EventRegistrationComponent`