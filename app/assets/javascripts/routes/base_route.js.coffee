App.BaseRoute = Ember.Route.extend
  setupController: (controller, model)->
    @_super(controller, model);
    controller.reset() if controller.reset?