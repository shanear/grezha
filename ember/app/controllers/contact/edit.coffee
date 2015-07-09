`import Ember from 'ember'`
`import ContactForm from 'grezha/mixins/contact-form'`

ContactEditController = Ember.ObjectController.extend ContactForm,
  errors: []
  assignableUsers: []

  # workaround to bug with Ember.Select
  # https://github.com/emberjs/ember.js/issues/4150
  selectedUserId: null
  recalculateSelectedUserId: (->
    @set("selectedUserId", @get('user.id'))
  ).observes("user.id")

  roleName: (->
    (@get('model.role') || "contact").capitalize()
  ).property("model")

  reset: ->
    @set('errors', [])

  actions:
    saveContact: ->
      contact = @get('model')

      selectedUser = @get('assignableUsers').findBy('id', @get('selectedUserId'))
      contact.set('user', selectedUser)

      if contact.isValid()
        contact.save().then(
          (contact)=>
            @transitionToRoute('contact', contact)
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors',contact.get('errors'))

`export default ContactEditController`