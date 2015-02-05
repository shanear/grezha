`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsIndexRoute = BaseRoute.extend AuthenticatedRouteMixin,
  setupController: (controller) ->
    controller.set('allConnections', @store.find('connection'))
    @_super(controller)

`export default ContactsIndexRoute`