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

  visit("/clients/" + contact.get("id"))
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
  visit("/clients/" + contact.get("id"))
  click("#add-relationship")
  fillIn("#new-relationship-name", "Bob Hope")
  click(".suggestions .highlighted")

  fillIn("#person-notes", "Notes")
  fillIn("#person-role", "Officer")
  fillIn("#person-contact-info", "111-1111-1111")
  andThen -> find("#contact-search").focus()
  click("#save-person")
  andThen ->
    ok(/Officer/.test(find(".relationship .type").text()),
      "A newly created relationship should appear")
  click(".delete-relationship")
  andThen ->
    equal(store.all('person').objectAt(0).get('name'), "Bob Hope",
      "Deleting the relationship shouldn't delete the person")
    equal(find(".relationship .type").length, 0,
      "A relationship should not show up after being deleted " + find(".relationship .type").length)

test "Show validation errors when relationship with a new Person lacks a role", ->
  visit("/clients/" + contact.get("id"))
  click("#add-relationship")
  fillIn("#new-relationship-name", "Wilfred the Cat")
  click(".suggestions .highlighted")

  click("#save-person")
  andThen ->
    equal(find(".errors li").length, 1,
    "There should have been an error because you didn't enter the role")
    equal(find(".errors li").text().trim(), "Role is required.",
    "There should have been an error because you didn't enter the role")

