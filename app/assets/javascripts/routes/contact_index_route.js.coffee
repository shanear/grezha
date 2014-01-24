App.ContactIndexRoute = Ember.Route.extend
  model: (params)->
    @modelFor("contact")