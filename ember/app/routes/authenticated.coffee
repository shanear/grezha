`import BaseRoute from './base'`
`import Ember from 'ember'`

AuthenticatedRoute = BaseRoute.extend
  beforeModel: ->
    @transitionTo('login') unless @session.isAuthenticated

  setupController: ->
    setContacts = @store.find('contact').then (contacts)=>
      @controllerFor('contacts').set('all', contacts)

    setEvents = @store.find('event').then (events)=>
      @controllerFor('events').set('all', events)

    Ember.RSVP.all([
      setContacts,
      setEvents,
      @store.find('connection'),
      @store.find('user')
    ])

`export default AuthenticatedRoute`