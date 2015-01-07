`import BaseRoute from './base';`

LoginRoute = BaseRoute.extend
  beforeModel: ->
    @transitionTo("/") if @session.isAuthenticated

`export default LoginRoute;`