App.VehiclesRoute = Ember.Route.extend
  model: ->
    @get('store').find('vehicle')