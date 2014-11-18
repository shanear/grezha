store = contact = null
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Relationship.FIXTURES = []
App.Person.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})
addingConnections = null

module "Connections Integration Tests",
  setup: ->
    # set the login cookie
    $.cookie('remember_token', "get logged in")

    Ember.run ->
      store = App.__container__.lookup("store:main")
      contact = store.createRecord('contact',
        name: "Ms McGrethory", createdAt: new Date(2012, 8, 6))
    addingConnections = (connection) ->
      click("#add-connection")
      fillIn("#newConnectionNote", connection.notes)
      fillIn("#mode", connection.mode)
      andThen ->
        console.log("something")
      click("#save-connection")

  teardown: ->
    App.reset()

test "Create and delete a connection", ->
  visit("/clients/" + contact.get("id"))

  click("#add-connection")
  fillIn("#newConnectionNote", "roll tide.")
  click("#save-connection")

  andThen ->
    ok(/roll tide/.test(find(".connection .note").text()),
      "A newly created connection should appear")

  visit("/clients/" + contact.get("id"))
  click(".delete-connection")
  click(".confirm")

  andThen ->
    equal(find(".connection .note").length, 0,
      "A connection should not show up after being deleted")

test "Create a connection with a specific meeting type", ->
  visit("/clients/" + contact.get("id"))
  click("#add-connection")
  fillIn("#newConnectionNote", "random notes")
  fillIn("#mode", "In Person")
  click("#save-connection")

  andThen ->
    ok(/In Person/.test(find(".connection .mode").text()), 
      "should display connection mode")



test "filter connections by type", ->
  Ember.run ->
    contact.save()
  visit("/clients/" + contact.get("id"))
  addingConnections({notes: "Phone connection 1", mode: "Phone"})
  addingConnections({notes: "Phone connection 1", mode: "Phone"})
  addingConnections({notes: "Called him about opportunity", mode: "In Person"})
  andThen ->
    equal(contact.get('connections.length'), 3, "this should be three")
    equal(find(".connection .note").length, 3,
      "All three should show up at first")
    equal(find(".mode-header.has-connections").length, 2, "only two sub-modes should appear")




test "Update last seen", ->
  visit("/clients/" + contact.get("id"))

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
