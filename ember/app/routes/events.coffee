`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    Ember.RSVP.hash({
      events: @get('store').find('event')
      programs: @get('store').find('program')
    })

`export default EventsRoute`