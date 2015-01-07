`import Ember from 'ember'`

LoginController = Ember.Controller.extend
  reset: ->
    @set("loginErrors", "")

  actions:
    login: ->
      @get("session").authenticate("authenticator:api", {
        email: @get("email"),
        password: @get("password")
      }).catch (error)=>
        if(error.status == 401)
          @set("loginErrors", "The username or password you entered didn't match an account. Please try again.")
        else
          @set("loginErrors", "Something went wrong while logging in. Please try again.")

`export default LoginController`