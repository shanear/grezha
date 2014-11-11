store = contact =  null
relationship = contactWithRelationship = null
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Relationship.FIXTURES = []
App.Person.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})

module "Relationship Integration Test",
  setup: ->
    # set the login cookie
    $.cookie('remember_token', "get logged in")

    Ember.run ->
      store = App.__container__.lookup("store:main")
      contact = store.createRecord('contact',
        name: "Ms McGrethory", createdAt: new Date(2012, 8, 6))

  teardown: ->
    App.reset()


test "Create a relationship to an existing Person", ->
  Ember.run ->
    store.createRecord('person', name: "Mums")

  visit("/contacts/" + contact.get("id"))
  click("#add-relationship")
  fillIn("#new-relationship-name", "M")

  andThen ->
    equal(find(".suggestions a").length, 2,
      "There should be two autocomplete suggestions.")
  click(".suggestions li:nth-of-type(1) a")
  andThen ->
    equal(find(".relationship .name").text().trim(), "Mums",
      "The relationship name should be Mums")


test "Create and delete a relationship with a new Person", ->
  visit("/contacts/" + contact.get("id"))
  click("#add-relationship")
  fillIn("#new-relationship-name", "Bob Hope")
  click(".suggestions .highlighted")

  fillIn("#new-person-notes", "Notes")
  fillIn("#new-person-role", "Officer")
  fillIn("#new-person-contact-info", "111-1111-1111")
  click("#save-relationship")
  andThen ->
    ok(/Officer/.test(find(".relationship .type").text()),
      "A newly created relationship should appear")
  click(".delete-relationship")
  click(".confirm")
  andThen ->
    equal(store.all('person').objectAt(0).get('name'), "Bob Hope",
      "Deleting the relationship shouldn't delete the person")
    equal(find(".relationship .type").length, 0,
      "A relationship should not show up after being deleted " + find(".relationship .type").length)

###
test "edits a relationship", ->
  visit("/contacts/" + contact.get("id") + "/relationships/" + relationship.get("id") + "/edit")
  fillIn("#newRelationshipName", "New Name")
  click("#save-relationship")
  andThen ->
    ok(/New Name/.test(find(".relationship .name").text()),
      "A newly edited relationship should update: ?" + find("#relationships").text())
###

