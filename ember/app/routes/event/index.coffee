`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventIndexRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @modelFor("event")

  setupController: (controller, model)->
    controller.set('contacts', @get('store').all('contact'))
    controller.set('model', model)

`export default EventIndexRoute`