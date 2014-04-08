App.BaseRoute = Ember.Route.extend
  setupController: (controller, post)->
    this._super(controller, post);
    controller.reset() if controller.reset?