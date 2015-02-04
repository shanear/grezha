`import Ember from 'ember'`
`import FilterByQuery from 'grezha/mixins/filter-by-query'`

VehiclesController = Ember.ArrayController.extend FilterByQuery,
  filterBy: ["licensePlate"]
  modelName: "Vehicle"

`export default VehiclesController`