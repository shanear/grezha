`import Ember from 'ember'`

VehicleEditController = Ember.ObjectController.extend
  errors: []
  reset: -> @set 'errors', []

  actions:
    saveVehicle: ->
      vehicle = @get('model')
      if vehicle.isValid()
        vehicle.save().then(
          (contact)=>
            @transitionToRoute('vehicle', vehicle)
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors',vehicle.get('errors'))

`export default VehicleEditController`