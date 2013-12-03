App.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo("contacts")