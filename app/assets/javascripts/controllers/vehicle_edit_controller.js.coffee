App.VehicleEditController = Ember.ObjectController.extend
  errors: []

  actions:
    saveVehicle: ->
      vehicle = @get('model')
      if vehicle.isValid()
        vehicle.save().then (vehicle)=>
          @transitionToRoute('vehicle', vehicle)
      else
        @set('errors',vehicle.get('errors'))
