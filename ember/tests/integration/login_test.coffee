`import Ember from "ember"`
`import { test } from 'ember-qunit'`
`import startApp from '../helpers/start-app'`

App = null

module 'Login integration test',
  setup: ->
    App = startApp()

    server = new Pretender()
    loginSuccessJson = { token: "TOKEN!" }
    server.post '/api/v2/authenticate', (request)->
      if(request.params.email == "lou@gmail.com" && request.params.password == "password")
        return [200, {"Content-Type": "application/json"}, JSON.stringify(loginSuccessJson)]
      else
        return [401, {"Content-Type": "application/json"}, ""]

  teardown: ->
    Ember.run(App, App.destroy)


test "Redirects to login page when not authenticated", ->
  expect(1)
  visit '/'
  andThen ->
    equal(currentPath(), "login",
      "Redirects to login when unauthorized")


test "Login with bad credentials", ->
  expect(1)
  visit "login"
  fillIn "#email", "lou@gmail.com"
  fillIn "#password", "bad!password"
  click "#login-submit"
  andThen ->
    equal(find("#login-errors").length, 1,
      "Errors should appear when login failed")