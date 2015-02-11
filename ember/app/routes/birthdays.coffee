`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

BirthdaysRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: ->
    @get('store').find('contact')

`export default BirthdaysRoute`