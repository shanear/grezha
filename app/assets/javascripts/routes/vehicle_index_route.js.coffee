App.VehicleIndexRoute = Ember.Route.extend
  model: (params)->
    @modelFor("vehicle")