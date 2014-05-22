store = contact = null

moduleForModel 'contact', 'Contact Model',
  needs: ['model:connection']
  setup: ->
    store = @store()
    Ember.run ->
      contact = store.createRecord('contact', name: "Ms McGrethory")


test 'isValid', ->
  ok(contact.isValid(), "Contact is valid by default")

  Ember.run -> contact.set("name", "")
  equal(contact.isValid(), false, "Contact isn't valid with empty name")


test 'isDuplicate', ->
  equal(contact.isDuplicate(), false, "Contact isn't duplicate by default")

  Ember.run ->
    store.createRecord('contact', name: "Fran")
    contact.set("name", "Fran")

  ok(contact.isDuplicate(), "Contact is duplicate when it has same name as another Contact")
