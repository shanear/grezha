App.VehicleEditRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor('vehicle')

  deactivate: ->
    @currentModel.rollback()
