`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  setupController: (controller, model)->
    controller.set('allContacts', @store.find('contact'))

  actions:
    sessionInvalidationSucceeded: ->
      @transitionTo('/login')

`export default ApplicationRoute`