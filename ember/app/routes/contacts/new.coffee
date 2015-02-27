`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    {
      name: params.name
      addedAt: new Date()
    }

  setupController: (controller, model)->
    @store.find('user')
    controller.set('assignableUsers',
      @store.filter('user', ((user)->
        user.get('role') == "field-op" || user.get('role') == "admin"
      ))
    )
    @_super(controller, model)

`export default ContactsNewRoute`