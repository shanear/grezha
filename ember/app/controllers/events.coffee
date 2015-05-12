`import Ember from 'ember'`

EventsController = Ember.ArrayController.extend
  eventSorting: ['startsAt']
  sortedEvents: Ember.computed.sort('model', 'eventSorting')

`export default EventsController`