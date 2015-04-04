`import Ember from 'ember'`
`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    @get('store').find('contact', {
      role: Ember.String.singularize(params.contact_role)
    })

`export default ContactsRoute`