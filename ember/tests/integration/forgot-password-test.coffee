`import Ember from "ember"`
`import { test } from 'ember-qunit'`
`import startApp from '../helpers/start-app'`
`import parsePostData from '../helpers/parse-post-data'`

App = null

module 'Forgot password integration test',
  setup: ->
    App = startApp()

    server = new Pretender()

    server.post '/api/v2/forgot-password', (request)->
      data = parsePostData(request.requestBody);

      if (data.email == "forgetful@gmail.com")
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({success: true})]
      else
        return [422,
          {"Content-Type": "application/json"},
          ""]

  teardown: ->
    Ember.run(App, App.destroy)


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
