`import Ember from 'ember'`

VehiclesNewController = Ember.ObjectController.extend
  errors: []
  isSaving: false
  reset: ->
    @set 'errors', []
    @set('isSaving', false)

  actions:
    createVehicle: ->
      newVehicle = @store.createRecord('vehicle', @get('model'))
      if newVehicle.isValid()
        @set('isSaving', true)
        newVehicle.save().then(
          (contact)=>
            @transitionToRoute('vehicle', newVehicle)
          ,(error)=>
            @store.unloadRecord(newVehicle)
            @set('isSaving', false)
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @store.unloadRecord(newContact)
        @set('errors', newVehicle.get('errors'))

`export default VehiclesNewController`