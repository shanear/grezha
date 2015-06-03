`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @get('store').find('program')

`export default EventsRoute`