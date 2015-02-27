`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`


ContactEditRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @modelFor('contact')

  setupController: (controller,model) ->
    @store.find('user')
    controller.set('assignableUsers',
      @store.filter('user', ((user)->
        user.get('role') == "field-op" || user.get('role') == "admin"
      ))
    )
    @_super(controller, model)

  deactivate: ->
    @currentModel.rollback()


`export default ContactEditRoute`