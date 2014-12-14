`import Base from 'simple-auth/authorizers/base'`
`import Ember from 'ember'`

Promise = Ember.RSVP.Promise

ApiAuthorizer = Base.extend
  authorize: (jqXHR, requestOptions)->
    jqXHR.setRequestHeader("Authorization",
      "Token token=\"#{@session.content.token}\"")

`export default ApiAuthorizer`