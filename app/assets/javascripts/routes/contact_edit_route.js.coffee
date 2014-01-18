App.ContactEditRoute = Ember.Route.extend
  model: (params)->
    this.modelFor("contact")