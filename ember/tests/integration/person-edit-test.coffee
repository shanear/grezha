`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Person edit page integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "edit a person", ->
  @api.set("contacts", [{id: 2, name: "Arnold Schwarz"}])
  @api.set("people", [{id: 1, name: "Danny Devito"}])

  visit("/clients/2/people/1/edit")
  fillIn("#person-name", "Danny Duchy")
  fillIn("#person-role", "actor")
  fillIn("#person-contact-info", "123-123-1234")
  fillIn("#person-notes", "these are the notes")
  click("#save-person")

  andThen =>
    person = @api.get("savedPerson")
    equal(person.name, "Danny Duchy")
    equal(person.role, "actor")
    equal(person.contact_info, "123-123-1234")
    equal(person.notes, "these are the notes")
    equal(currentURL(), "/clients/2",
      "Should return to contact page afterwards")


test "cancel editing a person", ->
  @api.set("contacts", [
    {id: 2, name: "Arnold Schwarz", relationship_ids: [4]}
  ])
  @api.set("people", [{id: 1, name: "Danny Devito"}])
  @api.set("relationships", [{id: 4, contact_id: 2, person_id: 1}])

  visit("/clients/2/people/1/edit")
  fillIn("#person-name", "Danny Duchy")
  fillIn("#person-role", "actor")
  click("#cancel-edit-person")

  andThen =>
    equal(currentURL(), "/clients/2",
      "Should return to contact page afterwards")
    ok(contains(".relationship .name", "Danny Devito"),
      "resets changes made in edit form")