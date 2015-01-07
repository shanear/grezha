`import Ember from 'ember'`

BaseRoute = Ember.Route.extend
  setupController: (controller, model)->
    @_super(controller, model);
    console.log(controller + "")
    controller.reset() if controller.reset?

`export default BaseRoute`