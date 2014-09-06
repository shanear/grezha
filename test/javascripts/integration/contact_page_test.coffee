store = contact = null
# TODO: rename this page and contact_index_page
# Set the store to a fixture adapter for now
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Relationship.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})


module "Contact Page Integration Tests",
  setup: ->
    # set the login cookie
    $.cookie('remember_token', "get logged in")

    Ember.run ->
      store = App.__container__.lookup("store:main")
      contact = store.createRecord('contact',
        name: "Ms McGrethory", createdAt: new Date(2012, 8, 6))

  teardown: ->
    App.reset()

test "Create and delete a relationship", ->
  visit("/contacts/" + contact.get("id"))
  click("#add-relationship")
  fillIn("#newRelationshipName", "Bob Hope")
  fillIn("#newRelationshipNote", "Notes")
  fillIn("#newRelationshipType", "Officer")
  fillIn("#newRelationshipContactInfo", "111-1111-1111")
  click("#save-relationship")
  andThen ->
    ok(/Officer/.test(find(".relationship .type").text()),
      "A newly created relationship should appear")
  click(".delete-relationship")
  click(".confirm")
  andThen ->
    equal(find(".relationship .type").length, 0, 
      "A relationship should not show up after being deleted " + find(".relationship .type").length)

test "Create and delete a connection", ->
  visit("/contacts/" + contact.get("id"))

  click("#add-connection")
  fillIn("#newConnectionNote", "roll tide.")
  click("#save-connection")

  andThen ->
    ok(/roll tide/.test(find(".connection .note").text()),
      "A newly created connection should appear")

  visit("/contacts/" + contact.get("id"))
  click(".delete-connection")
  click(".confirm")

  andThen ->
    equal(find(".connection .note").length, 0,
      "A connection should not show up after being deleted")

test "Create a connection with a specific meeting type", ->
  visit("/contacts/" + contact.get("id"))
  click("#add-connection")
  fillIn("#newConnectionNote", "random notes")
  fillIn("#mode", "In Person")
  click("#save-connection")

  andThen ->
    ok(/In Person/.test(find(".connection .mode").text()), 
      "should display connection mode")

test "Update last seen", ->
  visit("/contacts/" + contact.get("id"))

  andThen ->
    ok(/September 6th 2012/.test(find("#last-seen").text()),
       "Last seen should be equal to created at when no contacts")

  click("#add-connection")
  fillIn("#newConnectionNote", "roll tide.")
  fillIn(".selected-day", "1")
  fillIn(".selected-month", "1")
  fillIn(".selected-year", "2013")
  click("#save-connection")

  andThen ->
    ok(/January 1st 2013/.test(find("#last-seen").text()),
       "Last seen should be equal to date of the most recent connection")

  click("#add-connection")
  fillIn("#newConnectionNote", "go warriors.")
  fillIn(".selected-day", "2")
  fillIn(".selected-month", "1")
  fillIn(".selected-year", "2013")
  click("#save-connection")

  andThen ->
    ok(/January 2nd 2013/.test(find("#last-seen").text()),
       "Last seen should be equal to date of the most recent connection")
