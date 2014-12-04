App.ApplicationController = Ember.ObjectController.extend
  allContacts: []
  supportActive: false
  actions:
    toggleSupport: ->
      @set("supportActive", !@get("supportActive"))
