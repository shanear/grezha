`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsIndexRoute = BaseRoute.extend AuthenticatedRouteMixin,
  setupController: (controller) ->
    controller.set('allConnections', @store.find('connection'))
    @store.find('user')
    controller.set('assignableUsers',
      @store.filter('user', ((user)->
        user.get('role') == "field-op" || user.get('role') == "admin"
      ))
    )
    @_super(controller)

`export default ContactsIndexRoute`