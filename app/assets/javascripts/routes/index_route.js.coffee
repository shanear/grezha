App.IndexRoute = App.BaseRoute.extend
  redirect: ->
    @transitionTo("contacts")