`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

VehicleEditRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @modelFor('vehicle')

  deactivate: ->
    @currentModel.rollback()

`export default VehicleEditRoute`