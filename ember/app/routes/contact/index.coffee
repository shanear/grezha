`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactIndexRoute = BaseRoute.extend
  model: (params)->
    @modelFor("contact")

  setupController: (controller, model) ->
    controller.set('allPeople', @store.find('person'))
    @_super(controller, model)

`export default ContactIndexRoute`