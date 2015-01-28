`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ContactsRoute = BaseRoute.extend AuthenticatedRouteMixin, 
  model: ->
    @get('store').find('contact')

`export default ContactsRoute`