`import Ember from 'ember'`

EventsIndexController = Ember.ArrayController.extend
  selectProgramFilter: null
  programFilter: null
  isChangingFilter: false
  events: []

  isViewingPast: Ember.computed 'status', -> @get('status') == 'past'
  programFilterSlug: Ember.computed 'programFilter', -> @get('programFilter.slug') || 'all'

  filteredEvents: Ember.computed 'events.@each.isUpcoming', 'programFilter', 'status', (event)->
    @get('events').filter (event)=>
      (!@get('programFilter') || event.get('program.id') == @get('programFilter.id')) &&
      ((@get('status') == 'past' && !event.get('isUpcoming')) ||
       (@get('status') == 'upcoming' && event.get('isUpcoming')))

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

  onSelectProgramFitler: Ember.observer 'selectProgramFilter', ->
    @transitionToRoute('events', {
      programFilter: @get('programs').findBy('slug', @get('selectProgramFilter.slug'))
      status: @get('status')
    })

  programFilterOptions: Ember.computed 'programs.[]', 'programFilter', ->
    return [] unless @get('programs')

    [Ember.Object.create({name: 'All Programs', slug: 'all'})]
      .concat(@get('programs').content)
      .filter (program)=> program.get('id') != @get('programFilter.id')

  actions:
    toggleFilter: -> @set("isChangingFilter", !@get("isChangingFilter"))





`export default EventsIndexController`