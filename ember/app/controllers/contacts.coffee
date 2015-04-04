`import Ember from 'ember'`
`import FilterByQuery from 'grezha/mixins/filter-by-query'`

ContactsController = Ember.ArrayController.extend FilterByQuery,
  needs: ['application']
  filterBy: ["name", "user.name"]
  isSearchShowing: Ember.computed.alias("controllers.application.isSearchShowing")

  actions:
    newContact: ->
      @get('controllers.application').reset()
      @transitionToRoute("contacts.new", @get("filterQuery"))

`export default ContactsController`