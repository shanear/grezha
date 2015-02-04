`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

VehicleIndexRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @modelFor("vehicle")

`export default VehicleIndexRoute`