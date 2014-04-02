App.VehiclesNewController = Ember.ObjectController.extend
  errors: []
  actions:
    createVehicle: ->
      newVehicle = @store.createRecord('vehicle', @get('model'))
      if newVehicle.isValid()
        newVehicle.save().then (vehicle)=>
          @transitionToRoute('vehicle', vehicle)
      else
        @set('errors', newVehicle.get('errors'))
        newVehicle.rollback()
