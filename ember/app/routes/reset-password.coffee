`import BaseRoute from './base'`

ResetPasswordRoute = BaseRoute.extend
  setupController: (controller, model)->
    @_super(controller, model);
    controller.set('token', model.token)

`export default ResetPasswordRoute;`