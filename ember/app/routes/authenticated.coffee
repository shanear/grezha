`import BaseRoute from './base'`
`import Ember from 'ember'`

AuthenticatedRoute = BaseRoute.extend
  beforeModel: ->
    @transitionTo('login') unless @session.isAuthenticated

  model: ->
    Ember.RSVP.all([
      @store.find('contact'),
      @store.find('connection'),
      @store.find('user')
    ])

`export default AuthenticatedRoute`