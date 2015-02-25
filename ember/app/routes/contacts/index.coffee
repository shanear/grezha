`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsIndexRoute = BaseRoute.extend AuthenticatedRouteMixin,
  setupController: (controller) ->
    controller.set('allConnections', @store.find('connection'))
    controller.set('allUsers', @store.find('user'))
    @_super(controller)

`export default ContactsIndexRoute`