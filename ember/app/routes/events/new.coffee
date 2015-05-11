`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    startsAt = @get('datetime.now')()
    startsAt.setMinutes(0)
    { startsAt: startsAt }

`export default EventsNewRoute`