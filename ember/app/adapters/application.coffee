`import DS from 'ember-data'`

ApplicationAdapter = DS.ActiveModelAdapter.extend({
  host: EmberENV.apiURL
  namespace: "api/v2"
})

`export default ApplicationAdapter`