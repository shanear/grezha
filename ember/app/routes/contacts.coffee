`import Ember from 'ember'`
`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    Ember.String.singularize(params.contact_role)

  setupController: (controller, role)->
    controller.set('modelName', role)
    controller.set('model', @store.filter('contact', (contact)->
      contact.get('role') == role
    ))
    controller.set('all', @store.all('contact'))

`export default ContactsRoute`