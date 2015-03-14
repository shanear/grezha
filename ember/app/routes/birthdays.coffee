`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

BirthdaysRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: ->
    @get('store').find('contact')

  actions:
    toggleSearch: ->
      @transitionTo('contacts')
      @controllerFor('application').set('isSearchShowing', true)

`export default BirthdaysRoute`