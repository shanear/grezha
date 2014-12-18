`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

IndexRoute = Ember.Route.extend
  redirect: ->
    if @session.isAuthenticated
      @transitionTo('contacts')
    else
      @transitionTo('login')


`export default IndexRoute`