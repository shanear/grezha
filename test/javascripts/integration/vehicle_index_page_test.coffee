store = contact = null
# Set the store to a fixture adapter for now
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Vehicle.FIXTURES = []
App.Connection.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})

module "Contact Index Page integration tests", 
  setup: ->
    $.cookie('remember_token', 'get logged in')
    Ember.run ->
      store = App.__container__.lookup("store:main")
      store.createRecord("vehicle", 
        licensePlate: "123", usedBy: "Sketch dude", notes: "Dude looks so sketch")
      store.createRecord("vehicle", 
        licensePlate: "234", usedBy: "Other Sketch Dude")
      store.createRecord("vehicle", 
        licensePlate: "99432", usedBy: "Other Other Sketch Dude")
  teardown: ->
    App.reset()

test "should list all vehicles", ->

  visit("/vehicles")
  andThen ->
    equal(currentPath(), "vehicles.index", "should be" + currentPath())
    equal(find(".vehicle").length, 3, "Should show all vehicles at start")

test "should show vehicles matching on id", ->
  visit("/vehicles")
  fillIn("#vehicle-search", "23")
  andThen ->
    equal(find(".vehicle").length, 2, "Should show only vehicles matching based off search")