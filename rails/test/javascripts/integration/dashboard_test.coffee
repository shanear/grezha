store = contact = otherContact = user1 = null
# Set the store to a fixture adapter for now
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Relationship.FIXTURES = []
App.Person.FIXTURES = []
App.User.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})

module "Dashboard tests",
  setup: ->
    $.cookie('remember_token', 'get logged in')
    Ember.run ->
      store = App.__container__.lookup("store:main")
      store.unloadAll('connection')
      App.Connection.FIXTURES = []
  teardown: ->
    App.reset()

test "shows the number of connections on dashboard", ->
  Ember.run ->
    contact = store.createRecord('contact', name: "Ms McGrethory")
    otherContact  = store.createRecord('contact', name: "Sukirti")
    contact.save()
    otherContact.save()
  Ember.run ->
    store.createRecord('connection', note: "Test 1", contact: otherContact).save()
    store.createRecord('connection', note: "Test 2", contact: contact).save()
    store.createRecord('connection', note: "Test 3", contact: contact).save()
    store.createRecord('connection', note: "Test 4", contact: otherContact).save()
  visit("/clients/")
  andThen ->
    ok(/You've recorded 4 connections/.test(find(".dashboard").text()), find(".dashboard").text())