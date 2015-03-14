`import Ember from 'ember'`
`import FilterByQuery from 'grezha/mixins/filter-by-query'`

VehiclesController = Ember.ArrayController.extend FilterByQuery,
  needs: ['application']
  filterBy: ["licensePlate"]
  modelName: "Vehicle"
  isSearchShowing: Ember.computed.alias("controllers.application.isSearchShowing")

  reset: ->
    @set("isSearchShowing", true);


`export default VehiclesController`