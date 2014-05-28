store = contact = null

# Set the store to a fixture adapter for now
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})


# TODO: This is the first integration test, and sort of a trial run
#       standardize the setup for future integration tests
module "Connections Integration Tests",
  setup: ->
    # set the login cookie
    $.cookie('remember_token', "get logged in")

    Ember.run ->
      store = App.__container__.lookup("store:main")
      contact = store.createRecord('contact', name: "Ms McGrethory")

  teardown: ->
    App.reset()

test "Create a connection", ->
  visit("/contacts/" + contact.get("id"))
  click("#add-connection")
  fillIn("#newConnectionNote", "roll tide.")
  click("#save-connection")

  andThen ->
    equal(find(".connection .note").text(), "roll tide.",
      "A newly created connection should appear")
