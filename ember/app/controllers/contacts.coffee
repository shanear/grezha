`import Ember from 'ember'`
`import FilterByQuery from 'grezha/mixins/filter-by-query'`

ContactsController = Ember.ArrayController.extend FilterByQuery,
  filterBy: ["name", "user.name"]
  modelName: "Client"

`export default ContactsController`