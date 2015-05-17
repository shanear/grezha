`import Ember from 'ember'`

EventsController = Ember.ArrayController.extend
  eventSorting: ['startsAt']
  sortedEvents: Ember.computed.sort('model', 'eventSorting')
  eventsByDate: Ember.computed('@each', ->
    eventsByDate = {}
    @get('sortedEvents').forEach((eventObj)->
      date = moment(eventObj.get('startsAt')).startOf('day')
      eventsByDate[date] = (eventsByDate[date] || []).concat([eventObj])
    )
    eventsByDate
  )
  eventDays: Ember.computed('eventsByDate', ->
      eventsBD = @get('eventsByDate')
      x = Ember.keys(@get('eventsByDate')).map((date)->
          {
            date: date
            events: eventsBD[date]
          }
        )
      x
    )

`export default EventsController`