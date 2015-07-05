`import Ember from 'ember'`
`import FilterByQuery from 'grezha/mixins/filter-by-query'`

EventsController = Ember.Controller.extend
  unloggedEvents: Ember.computed.filterBy('all', 'needsLog', true)

`export default EventsController`