`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Edit contact page integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "errors when when no name entered", ->
  @api.set('contacts', [{id: 2, name: "Kat"}])
  visit("/clients/2/edit")
  fillIn("#name", "")
  click("#update-contact")
  andThen =>
    ok(!@api.get("savedContact"))
    findWithAssert(".errors")


test "saves correctly", ->
  @api.set('contacts', [{id: 4, name: "Jenkins"}])
  @api.set('users', [{id: 2, name: "Kat", role: "admin"}])
  visit("/clients/4/edit")
  fillIn("#name", "Stinkins")
  fillIn("#field-op", 2)
  fillIn("#birthday .selected-month", 3)
  fillIn("#birthday .selected-day", 2)
  click("#update-contact")
  andThen =>
    savedContact = @api.get("savedContact")
    equal(savedContact.name, "Stinkins")
    equal(savedContact.user_id, "2")
    ok(/1900-03-02T..:00:00.000Z/.test(savedContact.birthday))


test "Shows other gender in fill-in text field", ->
  @api.set('contacts', [{id: 4, name: "Jenkins", gender: "transman"}])
  visit("/clients/4/edit")
  andThen =>
    equal(find("#select-gender").val(), "Other",
      "Other gender should be selected in edit form")
    equal(find("#other-gender").val(), "Transman",
      "Other gender should be prefilled in text field")
