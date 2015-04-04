`import BaseRoute from './base'`

AuthenticatedRoute = BaseRoute.extend
  beforeModel: ->
    @transitionTo('login') unless @session.isAuthenticated

  setupController: ->
    Ember.RSVP.all([
      @store.find('contact'),
      @store.find('connection'),
      @store.find('user')
    ])

`export default AuthenticatedRoute`