`import Ember from 'ember'`

EventsIndexController = Ember.ArrayController.extend
  selectProgramFilter: null
  programFilter: null
  events: []

  filteredEvents: Ember.computed 'events', 'programFilter', (event)->
    @get('events').filter (event)=>
      !@get('programFilter') || event.get('program.id') == @get('programFilter.id')

  eventSorting: ['startsAt']
  sortedEvents: Ember.computed.sort('filteredEvents', 'eventSorting')

  eventsByDate: Ember.computed('sortedEvents.@each.startsAt', ->
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

  onSelectProgramFitler: (->
    @transitionToRoute('events', @get('selectProgramFilter.slug'))
    @set('selectProgramFilter', null)
  ).observes('selectProgramFilter')


`export default EventsIndexController`