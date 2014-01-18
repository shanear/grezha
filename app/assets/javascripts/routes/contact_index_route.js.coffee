App.ContactIndexRoute = Ember.Route.extend
  model: (params)->
    this.modelFor("contact")