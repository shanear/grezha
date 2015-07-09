`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'New contacts page integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "errors when when no name entered", ->
  visit("/clients/new")
  fillIn("#name", "")
  click("#save-client")
  andThen =>
    ok(!@api.get("savedContact"))
    findWithAssert(".errors")


test "saves gender correctly", ->
  @api.set('users', [{id: 1, name: "Kat", role: "admin"}])
  visit("/clients/new")
  andThen =>
    console.log(find("#hello-world").html())
  fillIn("#name", "James Franco")
  fillIn("#select-gender", "Other")
  fillIn("#other-gender", "Genderless")
  fillIn("#field-op", 1)
  click("#save-client")
  andThen =>
    newContact = @api.get("savedContact")
    equal(newContact.gender, "genderless")


test "saves correctly", ->
  @api.set('users', [{id: 1, name: "Kat", role: "admin"}])
  visit("/clients/new")
  fillIn("#name", "Newbie")
  fillIn("#field-op", 1)
  click("#save-client")
  andThen =>
    newContact = @api.get("savedContact")
    equal(newContact.name, "Newbie")
    equal(newContact.user_id, "1")
    equal(newContact.role, "client")
