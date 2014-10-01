store = contact =  null
relationship = contactWithRelationship = null
# TODO: consider using a Pretender server & use sync adapter
#       for more realistic coverage
App.Contact.FIXTURES = []
App.Connection.FIXTURES = []
App.Relationship.FIXTURES = []
App.Store = DS.Store.extend({adapter: DS.FixtureAdapter})

module "Relationship Integration Test",
  setup: ->
    # set the login cookie
    $.cookie('remember_token', "get logged in")

    Ember.run ->
      store = App.__container__.lookup("store:main")
      contactWithRelationship = store.createRecord('contact',
        name: "Miss Marvel", createdAt: new Date(2012, 8, 7))
      contact = store.createRecord('contact',
        name: "Ms McGrethory", createdAt: new Date(2012, 8, 6))
    Ember.run ->
      relationship = store.createRecord('relationship',
        contact: contactWithRelationship, name: 'Bob Hope', contactInfo: '999-9999-9999', relationshipType: "police officer")
    Ember.run ->
      contactWithRelationship.get('relationships').pushObject relationship

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

test "edits a relationship", ->
  visit("/contacts/" + contact.get("id") + "/relationships/" + relationship.get("id") + "/edit")
  fillIn("#newRelationshipName", "New Name")
  click("#save-relationship")
  andThen ->
    ok(/New Name/.test(find(".relationship .name").text()),
      "A newly edited relationship should update: ?" + find("#relationships").text())


