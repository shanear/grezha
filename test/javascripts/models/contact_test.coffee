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


test 'sortedConnections', ->
  Ember.run ->
    equal(contact.get('sortedConnections').length, 0,
      "sortedConnections should be empty when no connections")

  Ember.run ->
    store.createRecord('connection',
      note: "occurs second", occuredAt: new Date(2014, 9, 7), contact: contact)
    store.createRecord('connection',
      note: "occurs first", occuredAt: new Date(2014, 9, 6), contact: contact)
    store.createRecord('connection',
      note: "occurs third", occuredAt: new Date(2014, 9, 8), contact: contact)

    connections = contact.get('sortedConnections')

    equal(connections.length, 3, "There should be 3 sortedConnections")
    deepEqual(
      [connections[0].get('note'), connections[1].get('note'), connections[2].get('note')],
      ["occurs third", "occurs second", "occurs first"],
      "sortedConnections should be in reverse time order")
