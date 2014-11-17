store = contact = person = relationship = null
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Relationship.FIXTURES = []
App.Person.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})

module "Person Integration Test",
  setup: ->
    # set the login cookie
    $.cookie('remember_token', "get logged in")

    Ember.run ->
      store = App.__container__.lookup("store:main")
      contact = store.createRecord('contact',
        name: "Ms McGrethory", createdAt: new Date(2012, 8, 6))
      person = store.createRecord('person',
        name: "Sophster")

    Ember.run ->
      relationship = store.createRecord('relationship',
        person: person, contact: contact)

    Ember.run ->
      contact.get('relationships').pushObject relationship

  teardown: ->
    App.reset()

    # Reset the state of the data store after saving the person
    App.Person.FIXTURES = []

test "Edits a person from a relationship", ->
  visit("/clients/" + contact.get("id"))
  click(".relationship .summary a")
  fillIn("#person-name", "New Name")
  fillIn("#person-role", "Some role")
  click("#save-person")
  andThen ->
    ok(/New Name/.test(find(".relationship .name").text()),
      "A newly edited person should update: " + find("#relationships").text())

#test "Returns to contact when cancel editing a person", ->
#  visit("/contacts/" + contact.get("id"))
#  click(".relationship .summary a")
#  fillIn("#person-name", "Cancelled name")
#
#  click("#cancel-edit-person")
#  andThen ->
#    ok(true)
#ok(/Sophster/.test(find(".relationship .name").text()),
#  "Cancelling editing the person should not update: " + find("#relationships").text())

