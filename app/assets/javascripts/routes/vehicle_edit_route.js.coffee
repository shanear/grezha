App.VehicleEditRoute = Ember.Route.extend
  model: (params)->
    @modelFor('vehicle')

  deactivate: ->
    @currentModel.rollback()
