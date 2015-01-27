`import Ember from'ember'`
`import parsePostData from './parse-post-data'`

PretendApi = Ember.Object.extend({
  contacts: [],
  users: [],
  authToken: "",
  resetPasswordToken: "",

  start: ->
    server = new Pretender()
    @setupAccountEndpoints(server)
    @setupEndpoints(server)
    this

  setupEndpoints: (server)->
    @endpoints + ""
    server.get '/api/v2/contacts', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({contacts: @get('contacts')})]

    server.get '/api/v2/users/:id', (req)=>
      user = @get('users')[req.params.id]
      if user
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({user: user})]
      else
        return [404, {}, ""]

  setupAccountEndpoints: (server)->
    server.post '/api/v2/reset-password', (request)=>
      data = parsePostData(request.requestBody);
      auth = request.requestHeaders['Authorization'];
      if (auth != "Token token=\"#{@get('authToken')}\"" &&
          data.token != @get('resetPasswordToken'))
        return [401, {"Content-Type": "application/json"}, ""]

      if (data.password && data.password == data.password_confirmation)
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({success: true})]
      else
        return [422, {"Content-Type": "application/json"}, ""]

    server.post '/api/v2/forgot-password', (request)=>
      data = parsePostData(request.requestBody);
      response = [422, {"Content-Type": "application/json"}, ""]
      @get('users').forEach (user)->
        if (data.email == user.email)
          response = [200,
            {"Content-Type": "application/json"},
            JSON.stringify({success: true})]
      return response

    server.post '/api/v2/authenticate', (request)=>
      data = parsePostData(request.requestBody);
      response = [401, {"Content-Type": "application/json"}, ""]
      @get('users').forEach (user)->
        if(data.email == user.email &&
           data.password == user.password)
          response = [200,
            {"Content-Type": "application/json"},
            JSON.stringify(session: {
              token: "TOKEN!",
              username: user.name
            })]
      return response

    server.post '/api/v2/invalidate', ->
      return [200, {}, ""]
});

`export default PretendApi`
