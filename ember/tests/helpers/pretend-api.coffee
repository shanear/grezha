`import Ember from'ember'`
`import parsePostData from './parse-post-data'`

PretendApi = Ember.Object.extend({
  contacts: [],
  savedContact: null,
  deletedContactId: null,
  users: [],
  authToken: "",
  resetPasswordToken: "",

  start: ->
    server = new Pretender()
    @setupAccountEndpoints(server)
    @setupContactEndpoints(server)
    @setupUserEndpoints(server)
    this

  setupContactEndpoints: (server)->
    server.post '/api/v2/contacts', (req)=>
      data = JSON.parse(req.requestBody)
      @set('savedContact', data.contact)
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({contacts: @get('contacts')})]

    server.delete '/api/v2/contacts/:id', (req)=>
      @set('deletedContactId', req.params.id)
      return [200, {"Content-Type": "application/json"}, "{}"]

    server.get '/api/v2/contacts', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({contacts: @get('contacts')})]

    server.get '/api/v2/contacts/:id', (req)=>
      contacts = Ember.A(@get('contacts'))
      contact  = contacts.findBy('id', parseInt(req.params.id))
      if contact
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({contact: contact})]
      else
        return [404, {}, ""]

  setupUserEndpoints: (server)->
    server.get '/api/v2/users', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({users: @get('users')})]

    server.get '/api/v2/users/:id', (req)=>
      users = Ember.A(@get('users'))
      user  = users.findBy('id', parseInt(req.params.id))
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
