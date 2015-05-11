`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    console.log(@get('datetime.now')())
    starts = @get('datetime.now')()
    starts.setMinutes(0)
    { starts: starts }

`export default EventsNewRoute`