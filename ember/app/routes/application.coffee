`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  actions:
    sessionInvalidationSucceeded: ->
      @transitionTo('/login')

    newRecord: ->
      @transitionTo('contacts.new', {name: ""})

    toggleSearch: ->
      @controller.set("isMenuShowing", false)
      @controller.set("isSearchShowing", !@controller.get("isSearchShowing"))

`export default ApplicationRoute`