`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`


ContactEditRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @modelFor('contact')

  setupController: (controller,model) ->
    controller.set('allUsers', @store.find('user'))
    @_super(controller, model)

  deactivate: ->
    @currentModel.rollback()


`export default ContactEditRoute`