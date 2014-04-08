App.VehiclesRoute = App.BaseRoute.extend
  model: ->
    @get('store').find('vehicle')