store = contact = null

# Set the store to a fixture adapter for now
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})

module "Connections Integration Tests",
  setup: ->
    Ember.run ->
      store = App.__container__.lookup("store:main")
      contact = store.createRecord('contact', name: "Ms McGrethory")
  teardown: -> App.reset()

test "this works", ->
  visit("/contacts/" + contact.get("id"))
  click("#add-connection")
  fillIn("#newConnectionNote", "roll tide.")
  click("#save-connection")

  andThen ->
    equal(find(".connection .note").text(), "roll tide.")
