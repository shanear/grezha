App.LogoutRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('/') if App.get('loggedIn')
