`import BaseRoute from '../base';`

AuthenticatedIndexRoute = BaseRoute.extend
  beforeModel: ->
    @transitionTo('contacts', 'clients')

`export default AuthenticatedIndexRoute;`