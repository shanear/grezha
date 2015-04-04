`import Ember from 'ember'`
`import FilterByQuery from 'grezha/mixins/filter-by-query'`

VehiclesController = Ember.ArrayController.extend FilterByQuery,
  needs: ['application']
  filterBy: ["licensePlate"]
  modelName: "vehicle"
  isSearchShowing: Ember.computed.alias("controllers.application.isSearchShowing")

  reset: ->
    @set("isSearchShowing", true);

  actions:
    newVehicle: ->
      @get('controllers.application').reset()
      @transitionToRoute("vehicles.new", @get("filterQuery"))

`export default VehiclesController`