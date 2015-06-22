`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsIndexRoute = BaseRoute.extend AuthenticatedRouteMixin,
  redirect: ->
    @transitionTo('events.index', {status: 'upcoming'})

`export default EventsIndexRoute`