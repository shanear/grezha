`import Ember from'ember'`
`import parsePostData from './parse-post-data'`

PretendApi = Ember.Object.extend({
  online: true,
  errors: {},
  contacts: [],
  savedVehicle: null,
  savedContact: null,
  deletedContactId: null,
  deletedConnectionId: null,
  deletedRelationshipId: null,
  deletedParticipationId: null,
  users: [],
  vehicles: [],
  connections: [],
  participations: [],
  relationships: [],
  people: [],
  events: [],
  programs: [],
  authToken: "",
  resetPasswordToken: "",

  start: ->
    server = new Pretender()

    server.get '/api/v2/ping', ()=> return [200, {}, ""]

    @setupAccountEndpoints(server)
    @setupContactEndpoints(server)
    @setupConnectionEndpoints(server)
    @setupUserEndpoints(server)
    @setupPeopleEndpoints(server)
    @setupRelationshipEndpoints(server)
    @setupEventsEndpoints(server)
    @setupProgramsEndpoints(server)
    @setupVehiclesEndpoints(server)
    @setupParticipationsEndpoints(server)

    @set('errors', {})

    server.unhandledRequest = (verb, path, request)->
      console.warn("The API was hit with an unrecognized path:");
      console.warn("#{verb} #{path}");

    server.erroredRequest = (verb, path, request, error)->
      console.warn("There was an error with the pretend API:");
      console.warn("endpoint: #{verb} #{path}");
      console.warn("error:");
      console.warn(error);

    this

  setupVehiclesEndpoints: (server) ->
    server.get '/api/v2/vehicles/:id', (req) =>
      vehicles = Ember.A(@get('vehicles'))
      vehicle = vehicles.findBy('id', parseInt(req.params.id))
      if vehicle
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({vehicle: vehicle})]
      else
        return [404, {}, ""]

    server.get '/api/v2/vehicles', (req) =>
      return [200,
        {"Content-Type":"application/json"},
        JSON.stringify({vehicles: @get('vehicles')})]

    server.put '/api/v2/vehicles/:id', (req) =>
      vehicles = Ember.A(@get('vehicles'))
      vehicle = vehicles.findBy('id', parseInt(req.params.id))
      if vehicle
        data = JSON.parse(req.requestBody)
        @set('savedVehicle', data.vehicle)
        vehicleToReturn = data.vehicle
        vehicleToReturn.id = req.params.id
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({vehicle: vehicleToReturn})]
      else
        return [404, {}, ""]


    server.post '/api/v2/vehicles', (req) =>
      data = JSON.parse(req.requestBody)
      @set('savedVehicle', data.vehicle)
      return [200,
        {"Content-Type":"application/json"},
        JSON.stringify({vehicle: data.vehicle})]

  setupContactEndpoints: (server)->
    server.post '/api/v2/contacts', (req)=>
      data = JSON.parse(req.requestBody)
      @set('savedContact', data.contact)
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({contact: data.contact})]

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

    server.put '/api/v2/contacts/:id', (req)=>
      contacts = Ember.A(@get('contacts'))
      contact = contacts.findBy('id', parseInt(req.params.id))
      if contact
        data = JSON.parse(req.requestBody)
        @set('savedContact', data.contact)
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({contact: contact})]
      else
        return [404, {}, ""]

  setupConnectionEndpoints: (server)->
    server.get '/api/v2/connections', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({connections: @get('connections')})]

    server.post '/api/v2/connections', (req)=>
      data = JSON.parse(req.requestBody)
      @set('savedConnection', data.connection)
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({connection: data.connection})]

    server.get '/api/v2/connections/:id', (req)=>
      connections = Ember.A(@get('connections'))
      connection = connections.findBy('id', parseInt(req.params.id))
      if connection
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({connection: connection})]
      else
        return [404, {}, ""]

    server.delete '/api/v2/connections/:id', (req)=>
      @set('deletedConnectionId', req.params.id)
      return [200, {"Content-Type": "application/json"}, "{}"]

  setupPeopleEndpoints: (server)->
    server.post '/api/v2/people', (req)=>
      data = JSON.parse(req.requestBody)
      @set('savedPerson', data.person)
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({person: data.person})]

    server.put '/api/v2/people/:id', (req)=>
      people = Ember.A(@get('people'))
      person = people.findBy('id', parseInt(req.params.id))
      if person
        data = JSON.parse(req.requestBody)
        @set('savedPerson', data.person)
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({person: person})]
      else
        return [404, {}, ""]

    server.get '/api/v2/people/:id', (req) =>
      people = Ember.A(@get('people'))
      person = people.findBy('id', parseInt(req.params.id))
      if person
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({person: person})]
      else
        return [404, {}, ""]

    server.get '/api/v2/people', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({people: @get('people')})]

  setupRelationshipEndpoints: (server) ->
    server.post '/api/v2/relationships', (req) =>
      data = JSON.parse(req.requestBody)
      @set('savedRelationship', data.relationship)
      @get('relationships')
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({relationship: data.relationship})]

    server.get '/api/v2/relationships/:id', (req) =>
      relationships = Ember.A(@get('relationships'))
      relationship  = relationships.findBy('id', parseInt(req.params.id))
      if relationship
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({relationship: relationship})]
      else
        return [404, {}, ""]

    server.delete '/api/v2/relationships/:id', (req)=>
      @set('deletedRelationshipId', req.params.id)
      return [200, {"Content-Type": "application/json"}, "{}"]


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
      return [404, {}, ""] unless @get('online')
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

  setupEventsEndpoints: (server)->
    server.post '/api/v2/events', (req)=>
      data = JSON.parse(req.requestBody)
      @set('savedEvent', data["event"])
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({event: data["event"]})]
    server.get '/api/v2/events', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({events: @get('events')})]
    server.get '/api/v2/events/:id', (req)=>
      events = Ember.A(@get('events'))
      foundEvent = events.findBy('id', parseInt(req.params.id))
      if foundEvent
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({event: foundEvent})]
      else
        return [404, {}, ""]
    server.put '/api/v2/events/:id', (req)=>
      events = Ember.A(@get('events'))
      foundEvent = events.findBy('id', parseInt(req.params.id))
      if foundEvent
        data = JSON.parse(req.requestBody)
        @set('savedEvent', data.event)
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({event: foundEvent})]
      else
        return [404, {}, ""]
    server.delete '/api/v2/events/:id', (req)=>
      @set('deletedEventId', req.params.id)
      return [200, {"Content-Type": "application/json"}, "{}"]

  setupProgramsEndpoints: (server)->
    server.post '/api/v2/programs', (req)=>
      data = JSON.parse(req.requestBody)
      @set('savedProgram', data["program"])
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({program: data["program"]})]
    server.get '/api/v2/programs', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({programs: @get('programs')})]
    server.get '/api/v2/programs/:id', (req)=>
      programs = Ember.A(@get('programs'))
      program = programs.findBy('id', parseInt(req.params.id))
      if program
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({program: program})]
      else
        return [404, {}, ""]

  setupParticipationsEndpoints: (server) ->
    server.get '/api/v2/participations', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({participations: @get('participations')})]

    server.post '/api/v2/participations', (req) =>
      return [500, {}, ""] if @get('errors')['participations.create']

      data = JSON.parse(req.requestBody)
      @set('savedParticipation', data.participation)
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({participation: data.participation})]

    server.delete '/api/v2/participations/:id', (req)=>
      @set('deletedParticipationId', req.params.id)
      return [200, {"Content-Type": "application/json"}, "{}"]

    server.put '/api/v2/participations/:id', (req)=>
      participations = Ember.A(@get('participations'))
      foundParticipation = participations.findBy('id', parseInt(req.params.id))
      if foundParticipation
        data = JSON.parse(req.requestBody)
        @set('savedParticipation', data.participation)
        return [200,
          {"Content-Type": "application/json"},
          JSON.stringify({participation: foundParticipation})]
      else
        return [404, {}, ""]
});

`export default PretendApi`
