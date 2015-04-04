`import Ember from 'ember'`
`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @store.filter('contact', (contact)->
      contact.get('role') == Ember.String.singularize(params.contact_role)
    )

  setupController: (controller, model)->
    @_super(controller, model)
    controller.set('all', @store.find('contact'))

`export default ContactsRoute`