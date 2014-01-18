App.ContactsNewController = Ember.ObjectController.extend
  name: '',
  city: '',
  birthday: '',
  actions:
    createContact: ->
      name = @get("name")
      console.log "Contact created! name: #{name}, from: #{city}"
