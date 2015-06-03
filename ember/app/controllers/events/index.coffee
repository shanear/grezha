`import Ember from 'ember'`

EventsIndexController = Ember.ArrayController.extend
  programFilter: null
  events: []

  filteredEvents: Ember.computed.filter 'events', (event)->
    !@get('programFilter') || event.get('program.id') == @get('programFilter.id')

  eventSorting: ['startsAt']
  sortedEvents: Ember.computed.sort('filteredEvents', 'eventSorting')

  eventsByDate: Ember.computed('@each.startsAt', ->
    eventsByDate = {}
    @get('sortedEvents').forEach((eventObj)->
      date = moment(eventObj.get('startsAt')).startOf('day')
      eventsByDate[date] = (eventsByDate[date] || []).concat([eventObj])
    )
    eventsByDate
  )

  eventDays: Ember.computed 'eventsByDate', ->
    Ember.keys(@get('eventsByDate')).map (date)=>
      { date: date, events: @get('eventsByDate')[date] }

`export default EventsIndexController`