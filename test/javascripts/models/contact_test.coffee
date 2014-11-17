store = contact = null

moduleForModel 'contact', 'Contact Model',
  needs: ['model:connection', 'model:relationship', 'model:user', "model:person"]
  setup: ->
    store = @store()
    Ember.run ->
      contact = store.createRecord('contact', name: "Ms McGrethory")


test 'isValid name', ->
  ok(contact.isValid(), "Contact is valid by default")

  Ember.run -> contact.set("name", "")
  equal(contact.isValid(), false, "Contact isn't valid with empty name")

  Ember.run -> contact.set("name", "    ")
  equal(contact.isValid(), false, "Contact isn't valid with whitespace name")

  Ember.run -> contact.set("name", null)
  equal(contact.isValid(), false, "Contact isn't valid with undefined name")

  Ember.run -> contact.set("name", "Shanze")
  equal(contact.isValid(), true, "Contact is valid with name")

  Ember.run -> contact.set("name", "Shanze")
  equal(contact.isValid(), true, "Contact is valid with name")

test 'isValid phone', ->

  Ember.run -> contact.set("phone", "invalid phone #")
  equal(contact.isValid(), false, "phone # should be invalid when plain english")

  Ember.run -> contact.set("phone", "-")
  equal(contact.isValid(), false, "phone # should be invalid when special char")

  Ember.run -> contact.set("phone", "")
  equal(contact.isValid(), true, "phone # should be invalid when empty string")

  Ember.run -> contact.set("phone", "1112223333")
  equal(contact.isValid(), true, "phone # should be valid when sequence of numbers")

  Ember.run -> contact.set("phone", "111-222-3333")
  equal(contact.isValid(), true, "phone # should be valid when alternating numbers and dash")

  Ember.run -> contact.set("phone", "1-949-830-1657")
  equal(contact.isValid(), true, "phone # should be valid for international format")

  Ember.run -> contact.set("phone", "1-949-830-1657:0000")
  equal(contact.isValid(), true, "phone # should be valid when with extension")

test 'isDuplicate', ->
  equal(contact.isDuplicate(), false, "Contact isn't duplicate by default")

  Ember.run ->
    store.createRecord('contact', name: "Fran")
    contact.set("name", "Fran")

  ok(contact.isDuplicate(), "Contact is duplicate when it has same name as another Contact")

test "active status", ->
  setup = Ember.run -> contact.get('connections')
  todaysDate = moment()
  Ember.run ->
    connections = contact.get('connections')
    connections.pushObject store.createRecord('connection'
      note: "occurs second", occurredAt: todaysDate.toDate(), contact: contact)
    connections.pushObject store.createRecord('connection',
      note: "occurs first", occurredAt: todaysDate.toDate(), contact: contact)
  equal(contact.get("status"), "active", "Contact is active if a date before six months ")

test "inactive status", ->
  setup = Ember.run -> contact.get('connections')
  todaysDate = moment()
  Ember.run ->
    connections = contact.get('connections')
    connections.pushObject store.createRecord('connection'
      note: "occurs second", occurredAt: todaysDate.subtract('months', 7).toDate(), contact: contact)
  equal(contact.get("status"), "inactive", "Contact is inactive if no date before six months ")

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

test 'days until birthday', ->
  Ember.run ->
    contact.set("birthday", null)
  equal(contact.get("daysUntilBirthday"), null,
    "daysUntilBirthday should be null if birthday is null")

  Ember.run ->
    contact.set("birthday", moment().year(1970))
    equal(contact.get("daysUntilBirthday"), 0,
      "daysUntilBirthday should be 0 for the birthday boy!")

  Ember.run ->
    contact.set("birthday",
      moment().year(1999).add(363, 'days').startOf('day')
    )

    equal(contact.get("daysUntilBirthday"), 363,
      "daysUntilBirthday should be the days until next birthday," +
      " expected 363 but was " + contact.get("daysUntilBirthday"))
