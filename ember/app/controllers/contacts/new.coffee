`import Ember from 'ember'`
`import ContactForm from 'grezha/mixins/contact-form'`

ContactsNewController = Ember.ObjectController.extend ContactForm,
  errors: []
  assignableUsers: []
  isSaving: false
  reset: ->
    @set 'errors', []
    @set('isSaving', false)

  # workaround to bug with Ember.Select
  # https://github.com/emberjs/ember.js/issues/4150
  selectedUserId: (->
    @get("user.id")
  ).property("user")

  roleName: (->
    @get('model.role').capitalize()
  ).property("model")

  actions:
    createContact: ->
      newContact = @store.createRecord('contact', @get('model'))

      selectedUser = @get('assignableUsers').findBy('id', @get('selectedUserId'))
      newContact.set('user', selectedUser)

      if newContact.isValid()
        @set('isSaving', true)
        newContact.save().then(
          (contact)=>
            @transitionToRoute('contact', contact)
          ,(error)=>
            @store.unloadRecord(newContact)
            @set('isSaving', false)
            @set('errors', ["Something went wrong on the server, please try again later."]))

      else
        @set('errors', newContact.get('errors'))
        newContact.destroyRecord();

`export default ContactsNewController`