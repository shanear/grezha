`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

VehiclesRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: ->
    @get('store').find('vehicle')

`export default VehiclesRoute`