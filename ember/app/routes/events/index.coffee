`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    console.log(params)
    @get('store').find('event')

`export default EventsRoute`