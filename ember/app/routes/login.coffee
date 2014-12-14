`import Ember from 'ember';`

LoginRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo("/") if @session.isAuthenticated

`export default LoginRoute;`