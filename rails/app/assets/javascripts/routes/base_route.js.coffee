App.BaseRoute = Ember.Route.extend
  beforeModel: ->
    unless App.get('loggedIn')
      if App.get('online')
        window.location.replace("login")
      else
        @transitionTo('/logout')

  setupController: (controller, model)->
    @_super(controller, model);
    controller.reset() if controller.reset?