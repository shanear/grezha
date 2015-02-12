`import Ember from 'ember'`

ResetPasswordController = Ember.Controller.extend
  needs: ['login', 'contacts']

  reset: ->
    @set("newPassword", "")
    @set("newPasswordConfirm", "")
    @set("errors", "")

  validatePasswordsMatch: ()->
    if @get('newPassword') != @get('newPasswordConfirm')
      @set("errors", "The passwords that you entered didn't match. Please try again.")
      return false
    return true

  onSuccess: (nextPath)->
    @transitionToRoute('login')
    @set("controllers." + nextPath + ".notice",
      "Your password was reset successfully.")

  actions:
    submit: ->
      return false unless @validatePasswordsMatch()

      resetPassword = Ember.$.post(
        EmberENV.apiURL + '/api/v2/reset-password',
        {
          token: @get('token'),
          email: @get('email'),
          password: @get('newPassword'),
          password_confirmation: @get('newPasswordConfirm')
        }
      )

      resetPassword.done =>
        Ember.run =>
          if @get('session.isAuthenticated')
            @onSuccess('contacts')
          else
            @onSuccess('login')

      resetPassword.fail (error)=>
        Ember.run =>
          @set("errors", "The reset password link doesn't appear to be working with the email you entered. Please try again.")

`export default ResetPasswordController`