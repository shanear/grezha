App.BaseRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('/logout') unless App.get('loggedIn')

  setupController: (controller, model)->
    @_super(controller, model);
    controller.reset() if controller.reset?