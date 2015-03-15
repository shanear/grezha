`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

VehiclesRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: ->
    @get('store').find('vehicle')

  actions:
    newRecord: ->
      @transitionTo('vehicles.new', {name: ""})

`export default VehiclesRoute`