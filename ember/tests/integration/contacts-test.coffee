`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import parsePostData from '../helpers/parse-post-data'`

module 'Contacts page integration test',
  setup: ->
    @app = startApp()
    @contacts = []

    server = new Pretender()
    server.get '/api/v2/contacts', =>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({contacts: @contacts})]
    server.get '/api/v2/users/:id', (req)=>
      return [200,
        {"Content-Type": "application/json"},
        JSON.stringify({user: @users[req.params.id]})]

    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "shows all people in sidebar when no search query entered", ->
  @contacts = [{id: 1, name: "Cat"}, {id: 2, name: "Sted"}]
  visit("/clients/")
  andThen =>
    equal(find(".contact").length, 2,
      "shows all contacts in list")


test "shows only people with matching string in name", ->
  @contacts = [{id: 1, name: "Cat"}, {id: 2, name: "Cat Dog"}, {id: 3, name: "Sted"}]

  visit("/clients/")
  fillIn("#contact-search", "Cat")
  andThen ->
    equal(find(".contact").length, 2, "Should show matching on name")


test 'show only people in sidebar with matching user', ->
  pat = {id: 0, name: "Pat Mims"}
  marc = {id: 1, name: "Marc Jan"}
  @users = [pat, marc]
  @contacts = [{id: 1, name: 'New Boy', user_id: pat.id},
               {id: 2, name: 'Hip Girl', user_id: pat.id},
               {id: 3, name: 'Old Dude', user_id: marc.id}]

  visit("/clients/")
  fillIn("#contact-search", "Pat")
  andThen ->
    ok(/Hip Girl/.test(find(".contact").text()), "Should contain Hip Girl")
    ok(/New Boy/.test(find(".contact").text()), "Should contain New Boy")
    ok(!/Old Dude/.test(find(".contact").text()), "Should not contain old dude since different user")

