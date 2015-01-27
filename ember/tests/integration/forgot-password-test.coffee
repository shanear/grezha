`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Forgot password integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    @api.set('users', [{email: "forgetful@gmail.com"}])

  teardown: ->
    Ember.run(@app, @app.destroy)


test "Redirects to login page when successful", ->
  expect(2)
  visit '/forgot-password'
  fillIn "#email", "forgetful@gmail.com"
  click "#forgot-password-submit"
  andThen ->
    equal(currentURL(), '/login',
      'Forgot password should succeed')
    equal(find('#notice').length, 1,
      'There should be a success message')


test "Displays error when unsuccessful", ->
  expect(1)
  visit "/forgot-password"
  fillIn "#email", "nobodydude@gmail.com"
  click "#forgot-password-submit"
  andThen ->
    equal(find("#errors").length, 1,
      "Errors should appear when login failed")
