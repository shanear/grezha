`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Reset password integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    @api.set('authToken', 'abc123')
    @api.set('resetPasswordToken', 'reset123')

  teardown: ->
    invalidateSession()
    Ember.run(@app, @app.destroy)


test "When for current user", ->
  expect(3)
  authenticateSession()
  currentSession().set('username', 'Lou')
  currentSession().set('token', 'abc123')

  visit '/reset-password/current-user'

  andThen ->
    equal(find('form .email').length, 0,
      'No email field if logged in')

  fillIn('.new-password', 'newpassbird')
  fillIn('.new-password-confirm', 'newpassbird')
  click '#reset-password-submit'

  andThen ->
    equal(currentURL(), '/clients',
      'Reset password should succeed and redirect to root')
    equal(find('#notice').length, 1,
      'There should be a success message')
    invalidateSession()


test "While not logged in", ->
  expect(2)
  visit '/reset-password/reset123'
  fillIn('.email', 'person@gmail.com')
  fillIn('.new-password', 'newpassbird')
  fillIn('.new-password-confirm', 'newpassbird')
  click '#reset-password-submit'

  andThen ->
    equal(currentURL(), '/login',
      'Reset password should succeed and redirect to root')
    equal(find('#notice').length, 1,
      'There should be a success message')


test "When confirmation doesn't match", ->
  visit '/reset-password/reset123'
  fillIn('.email', 'person@gmail.com')
  fillIn('.new-password', 'newpassbird')
  fillIn('.new-password-confirm', 'newpassturd')
  click '#reset-password-submit'

  andThen ->
    equal(currentPath(), 'reset-password',
      "Reset password shouldn't transition route when failed")
    ok(/passwords.*didn't match/.test(find('#errors').text()),
      'There should be a password error')


test "When token doesn't match email", ->
  visit '/reset-password/reset-wrong123'
  fillIn('.email', 'person@gmail.com')
  fillIn('.new-password', 'newpassbird')
  fillIn('.new-password-confirm', 'newpassbird')
  click '#reset-password-submit'

  andThen ->
    equal(currentPath(), 'reset-password',
      "Reset password shouldn't transition route when failed")
    ok(/email/.test(find('#errors').text()),
      'There should be an email error')
