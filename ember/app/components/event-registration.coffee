`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`


EventRegistrationComponent = Ember.Component.extend
  tagName: 'li'
  registration: {}
  isBeingDeleted: false

  setup: Ember.on 'init', ->
    @set('isBeingDeleted', false)

  actions:
    deleteRegistration: (registration)-> @set("isBeingDeleted", true)
    cancelDeleteRegistration: -> @set('isBeingDeleted', false)
    confirmDeleteRegistration: ->
      @get('registration').destroyRecord()



`export default EventRegistrationComponent`