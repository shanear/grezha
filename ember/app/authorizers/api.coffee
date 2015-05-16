`import Base from 'simple-auth/authorizers/base'`
`import Ember from 'ember'`

Promise = Ember.RSVP.Promise

ApiAuthorizer = Base.extend
  authorize: (jqXHR, requestOptions)->
    if(@session.isAuthenticated)
      jqXHR.setRequestHeader("Authorization",
        "Token token=\"#{@session.content && @session.content.token}\"")

`export default ApiAuthorizer`