`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventIndexRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)-> @modelFor("event")

`export default EventIndexRoute`