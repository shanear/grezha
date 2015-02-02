`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

PersonEditRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @modelFor('person')

  deactivate: ->
    @currentModel.rollback()

`export default PersonEditRoute`