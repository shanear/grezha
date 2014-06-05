App.VehiclesNewController = Ember.ObjectController.extend
  errors: []
  reset: -> @set 'errors', []

  actions:
    createVehicle: ->
      newVehicle = @store.createRecord('vehicle', @get('model'))
      if newVehicle.isValid()
        newVehicle.save().then(
          (contact)=>
            @transitionToRoute('vehicle', vehicle)
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors', newVehicle.get('errors'))
