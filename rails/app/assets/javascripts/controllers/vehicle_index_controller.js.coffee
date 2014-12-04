App.VehicleIndexController = Ember.ObjectController.extend App.HasConfirmation,
  needs: "vehicles"

  actions:
    deleteVehicle: ->
      @set 'confirmation',
        heading: "Are you sure?"
        content: "Are you sure you want to delete this vehicle? It will be gone forever!"
        show: true
        button: "Delete"
        action: =>
          @get('model').deleteRecord()
          @get('model').save()
          @transitionToRoute('vehicles')