`import Ember from "ember"`
`import { test } from 'ember-qunit'`
`import startApp from '../helpers/start-app'`
`import parsePostData from '../helpers/parse-post-data'`

App = null

module 'Login integration test',
  setup: ->
    App = startApp()

    server = new Pretender()
    loginSuccessJson = {
      session: {
        token: "TOKEN!",
        username: "Lou"
      }
    }
    server.post '/api/v2/authenticate', (request)->
      data = parsePostData(request.requestBody);

      if (data.email == "lou@gmail.com" &&
          data.password == "password")
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify(loginSuccessJson)]
      else
        return [401, {"Content-Type": "application/json"}, ""]

    server.post 'api/v2/invalidate', ->
      return [200, {}, ""]

  teardown: ->
    Ember.run(App, App.destroy)


test "Redirects to login page when not authenticated", ->
  expect(1)
  visit '/'
  andThen ->
    equal(currentURL(), "/login",
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


test "Login with good credentials", ->
  visit "login"
  fillIn "#email", "lou@gmail.com"
  fillIn "#password", "password"
  click "#login-submit"

  andThen ->
    equal(currentURL(), "/clients", "Redirects to index (clients)")
    equal(find("#username").text().trim(), "Lou"
      "Sets current user to authenticated username")


test "Login redirects to index when authenticated", ->
  visit "login"
  fillIn "#email", "lou@gmail.com"
  fillIn "#password", "password"
  click "#login-submit"
  visit "login"
  andThen ->
    equal(currentURL(), "/clients", "Redirects to index (clients)")

test "Logout", ->
  visit "login"
  fillIn "#email", "lou@gmail.com"
  fillIn "#password", "password"
  click "#login-submit"
  click "#logout"
  andThen ->
    equal(currentURL(), "/login", "Redirects to login")