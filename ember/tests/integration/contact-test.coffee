`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Contact page integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "shows correctly for contact with no data", ->
  @api.set('contacts', [{id: 1, name: "Jane Doe"}])
  visit("/clients/1")
  andThen =>
    ok(contains("#contact-name", "Jane Doe"))
    ok(contains("#contact-birthday", "unknown"))
    ok(contains("#contact-user", "unassigned"))
    ok(contains("#contact-from", "unknown"))


test "shows correctly formatted information for contact", ->
  @api.set('users', [{id: 1, name: "Kat"}])
  @api.set('contacts', [{
    id: 1,
    name: "Suzie",
    birthday: "1990-03-02T08:00:00.000Z",
    created_at: "2015-01-26T18:48:31.142Z",
    added_at: "2015-01-22T18:48:31.142Z",
    city: "San Francisco",
    phone: "123-123-5555",
    user_id: 1,
    bio: "Line one\nLine two"
  }])
  visit("/clients/1")
  andThen =>
    ok(contains("#contact-name", "Suzie"))
    ok(contains("#contact-birthday", "March 2nd 1990"))
    ok(contains("#contact-user", "Kat"))
    ok(contains("#contact-from", "San Francisco"))
    ok(contains("#last-seen", "January 26th 2015"))
    ok(contains("#added-at", "added January 22nd 2015"))
    ok(contains("#contact-phone", "123-123-5555"))
    ok(contains(".bio", "Line one<br>Line two"))


test "delete a contact", ->
  @api.set('contacts', [{id: 7, name: "Jane Doe"}])
  visit("/clients/7")
  click("#delete-contact")
  click("#confirmation .cancel")
  andThen -> ok(!exists("#confirmation"))
  click("#delete-contact")
  click("#confirmation .confirm")
  andThen =>
    equal(@api.get('deletedContactId'), '7')


test "add a relationship", ->
  @api.set('contacts', [{id: 7, name: "Jane Doe"}])
  visit("/clients/7")
  click("#add-relationship")
  click("#cancel-new-relationship")
  andThen ->
    ok(!exists("#new-relationship-name"))

  click("#add-relationship")
  fillIn("#new-relationship-name", "Mother May")
  click(".suggestions.active a")
  fillIn("#person-role", "mom")
  click("#save-person")
  andThen =>
    savedPerson = @api.get('savedPerson')
    equal(savedPerson.name, "Mother May")
    equal(savedPerson.role, "mom")
    savedRelationship = @api.get('savedRelationship')
    equal(savedRelationship.contact_id, 7)


test "add relationship to an existing person", ->
  @api.set('contacts', [{id: 4, name: "Jonny Manzel"}])
  @api.set('people', [{id: 5, name: "Coach Carter", role: "coach"}])
  visit("/clients/4")
  click("#add-relationship")
  fillIn("#new-relationship-name", "Coach C")
  click(".suggestions.active a")
  andThen =>
    savedRelationship = @api.get('savedRelationship')
    equal(savedRelationship.contact_id, 4)
    equal(savedRelationship.person_id, 5)


test "shows relationships for a contact", ->
  @api.set('contacts', [{id: 8, name: "Leeroy Jenkins", relationship_ids: [1000]}])
  @api.set('people',[{
    id: 2,
    name: "Tatiana",
    role: "Fairy Princess"
    contact_info: "hapily@everafter.com"
  }])
  @api.set('relationships', [{id: 1000, contact_id: 8, person_id: 2}])
  visit("/clients/8")
  andThen =>
    ok(contains(".relationship .name", "Tatiana"))
    ok(contains(".relationship .type", "Fairy Princess"))
    ok(contains("a[href='mailto:hapily@everafter.com']",
                "hapily@everafter.com"))


test "deletes a relationship", ->
  @api.set('contacts', [{
    id: 8,
    name: "Leeroy Jenkins",
    relationship_ids: [1000]
  }])
  @api.set('people',[{id:2, name: "Tatiana", role: "Fairy Princess"}])
  @api.set('relationships', [{id: 1000, contact_id: 8, person_id: 2}])
  visit("/clients/8")
  click(".delete-relationship")
  andThen =>
    ok(contains("#relationships", "no relationships"))
    equal(@api.get('deletedRelationshipId'), 1000)