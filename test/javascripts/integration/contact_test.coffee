store = contact = null
# Set the store to a fixture adapter for now
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Relationship.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})

module "Contact Index Page integration tests", 
  setup: ->
    $.cookie('remember_token', 'get logged in')
    Ember.run ->
      store = App.__container__.lookup("store:main")
  teardown: ->
    App.reset()
test "fills in a new contact", ->
  visit("/contacts/")
  fillIn("#contact-search", "Anna Bobana")
  click(".new-contact > a")
  andThen ->
    equal(currentPath(), "contacts.new", "should be" + currentPath())
    equal("Anna Bobana", find("#contact-search").val(), "names should be same " + find("#contact-search").val())
    equal("Anna Bobana", find("#name").val(), "names should be same " + find("#name").val())
    testName = find(".new-contact > a").text()
    equal("Add Anna Bobana", find(".new-contact > a").text().trim(), "should be Add + name")

test "creates a new contact", ->
  visit("/contacts/")
  fillIn("#contact-search", "Anna Bobana")
  click(".new-contact > a")
  click("#save-contact")
  andThen ->
    equal(currentPath(), "contacts.contact.index", "should be" + currentPath())
    equal("Anna Bobana", find("h3#contact-name").text(), "name should display in header")
    click(".delete-contact")
    click(".confirm")

test "creates a new contact with full information", ->
  visit("/contacts/")
  fillIn("#contact-search", "Ion Worris")
  click(".new-contact > a")
  fillIn("#city", "Lake Forest")
  fillIn("#bio", "just wants to be king of the pirates")
  click("#save-contact")
  andThen ->
    equal("Ion Worris", find("h3#contact-name").text(), "name should display in header")
    ok(find(".top-info").text().indexOf("Lake Forest") > -1, "should find the city in the top info")
    ok(find(".bio").text().indexOf("just wants to be king of the pirates") > -1, "should find the bio")
    click(".delete-contact")
    click(".confirm")

test "shows all people in sidebar with same name", ->
  Ember.run ->
    store.unloadAll('contact')
  Ember.run ->
    contact = store.createRecord('contact',
      name: "Catherine MacKinnon", createdAt: new Date(2012, 8, 6))
    contact2 = store.createRecord('contact',
      name: "Catherine MacDonald", createdAt: new Date(2012, 8, 6))
    otherContact = store.createRecord('contact', 
      name: "Andrea Dworkin", createdAt: new Date(2012,8,7))
  visit("/contacts/")
  andThen ->
    equal(find(".contact").length, 3, "Should show three people in list by default: " + find("li.contact").length)
test "shows only people with matching string in name", -> 
  Ember.run ->
    contact = store.createRecord('contact',
      name: "Catherine MacKinnon", createdAt: new Date(2012, 8, 6))
    contact2 = store.createRecord('contact',
      name: "Catherine MacDonald", createdAt: new Date(2012, 8, 6))
    otherContact = store.createRecord('contact', 
      name: "Andrea Dworkin", createdAt: new Date(2012,8,7))
  visit("/contacts/")
  fillIn("#contact-search", "Cat")
  andThen ->
    equal(find(".contact").length, 2, "Should show matching on name")

test "matching people on name should not care if matching on first or last name", ->
  Ember.run ->
    contact = store.createRecord('contact',
      name: "Catherine MacKinnon", createdAt: new Date(2012, 8, 6))
    contact2 = store.createRecord('contact',
      name: "Catherine MacDonald", createdAt: new Date(2012, 8, 6))
    otherContact = store.createRecord('contact', 
      name: "Andrea Dworkin", createdAt: new Date(2012,8,7))
  visit("/contacts/")
  fillIn("#contact-search", "Dwork")
  andThen ->
    equal(find(".contact").length, 1, "Should show matching on last name")
