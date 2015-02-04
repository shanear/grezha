`import Ember from 'ember'`
`import HasConfirmation from 'grezha/mixins/has-confirmation'`

VehicleIndexController = Ember.ObjectController.extend HasConfirmation,
  needs: ["vehicles"]
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

`export default VehicleIndexController`