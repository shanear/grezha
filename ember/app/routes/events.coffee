`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    Ember.RSVP.hash({
      events: @get('store').find('event')
      programs: @get('store').find('program')
      participations: @get('store').find('participation')
    })

  actions:
    newRecord: ->
      @transitionTo('events.new')

    toggleSearch: ->
      @transitionTo('contacts.index', 'clients')
      @controllerFor('application').set('isSearchShowing', true)


`export default EventsRoute`