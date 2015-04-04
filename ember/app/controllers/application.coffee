`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  needs: ['authenticated']
  reset: ->
    @get('controllers.authenticated').reset()

  actions:
    toggleSupport: ->
      @set("supportActive", !@get("supportActive"))

    toggleMenu: ->
      @set("isSearchShowing", false)
      @set("isMenuShowing", !@get("isMenuShowing"))

`export default ApplicationController`