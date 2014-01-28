App.ContactEditController = Ember.ObjectController.extend
  actions:
    saveContact: ->
      @get('model').save().then (contact)=>
        @transitionToRoute('contact', contact)
