store = contact = null

moduleForModel 'contact', 'Contact Model',
  needs: ['model:connection', 'model:relationship']
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


asyncTest 'sortedConnections', ->
  setup = Ember.run -> contact.get('connections')

  setup.then ->
    Ember.run ->
      equal(contact.get('sortedConnections.length'), 0,
        "sortedConnections should be empty when no connections")

      connections = contact.get('connections')
      connections.pushObject store.createRecord('connection',
        note: "occurs second", occurredAt: new Date(2014, 9, 7), contact: contact)
      connections.pushObject store.createRecord('connection',
        note: "occurs first", occurredAt: new Date(2014, 9, 6), contact: contact)
      connections.pushObject store.createRecord('connection',
        note: "occurs third", occurredAt: new Date(2014, 9, 8), contact: contact)

    Ember.run ->
      sortedConnections = contact.get('sortedConnections')
      equal(sortedConnections.get('length'), 3, "There should be 3 sortedConnections")
      deepEqual(
        sortedConnections.mapBy('note'),
        ["occurs third", "occurs second", "occurs first"],
        "sortedConnections should be in reverse time order")

    start()

one = undefined

test "can have relationships", ->
  relationships = []
  relLength = "meh"
  Ember.run ->
    relationships = contact.get('relationships')
  Ember.run ->
    relationships.pushObject store.createRecord('relationship', contact : contact, notes: "something")
  Ember.run ->
    relLength = contact.get('relationships.length')
  andThen ->
    Ember.run ->
      equal(relLength, 1, "length should be " + relLength)


asyncTest 'last seen connection', ->
  setup = Ember.run -> contact.get('connections')

  setup.then ->
    Ember.run ->
      equal(contact.get('lastSeen'), contact.get('createdAt'), "Should be created at time when connection last seen")
      connections = contact.get('connections')
      connections.pushObject store.createRecord('connection',
        note: "occurs second", occurredAt: new Date(2014, 9, 7), contact: contact)
      connections.pushObject store.createRecord('connection',
        note: "occurs first", occurredAt: new Date(2014, 9, 6), contact: contact)
    Ember.run ->
      deepEqual(contact.get('lastSeen'), new Date(2014, 9, 7), "uses the last seen date from connections " +contact.get('lastSeen'))
  start()