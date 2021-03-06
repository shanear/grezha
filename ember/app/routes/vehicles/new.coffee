`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

VehiclesNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)-> {
  	licensePlate: params.name
  }

`export default VehiclesNewRoute`