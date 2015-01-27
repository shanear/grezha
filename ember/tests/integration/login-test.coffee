`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Login integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    @api.set('users', [{
      name: "Lou"
      email: "lou@gmail.com"
      password: "password"
    }])

  teardown: ->
    Ember.run(@app, @app.destroy)


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