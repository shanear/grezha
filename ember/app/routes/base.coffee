`import Ember from 'ember'`

BaseRoute = Ember.Route.extend
  setupController: (controller, model)->
    @_super(controller, model);
    controller.reset() if controller.reset?

  actions:
    willTransition: ->
      this.controllerFor("application").reset();

`export default BaseRoute`