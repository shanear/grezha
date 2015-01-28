`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    {
      name: params.name
      addedAt: new Date()
    }

  setupController: (controller, model)->
    controller.set('allUsers', @store.find('user'))
    @_super(controller, model)

`export default ContactsNewRoute`