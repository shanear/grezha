`import Ember from 'ember'`
`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel('contact', 'Contact Model'
  needs: ['model:connection', 'model:user', 'model:relationship', 'model:person', 'model:participation', 'model:event']
  setup: ->
    stop()
    Ember.run =>
      find1 = @store().find('contact', 'base').then (contact)=>
        @contact = contact

      find2 = @store().find('contact', 'has-connections').then (contact)=>
        @contactWithConnections = contact
        @contactWithConnections.get('connections')

      find3 = @store().find('user', 'base').then (user)=>
        @user = user

      Ember.RSVP.all([find1, find2, find3]).finally(start)
)


test "createdAt", ->
  now = new Date()
  timekeeper.freeze(now)
  equal(@contact.get("createdAt"), now, "defaults to now")


test 'isValid validates name', ->
  ok(@contact.isValid(), "is valid with name")

  Ember.run => @contact.set("name", "")
  equal(@contact.isValid(), false,
    "isn't valid with empty name")

  Ember.run => @contact.set("name", "    ")
  equal(@contact.isValid(), false,
    "isn't valid with whitespace name")

  Ember.run => @contact.set("name", null)
  equal(@contact.isValid(), false,
    "isn't valid with undefined name")


test 'isValid validates phone number', ->
  Ember.run => @contact.set("phone", "invalid phone #")
  equal(@contact.isValid(), false,
    "is invalid when plain english")

  Ember.run => @contact.set("phone", "-")
  equal(@contact.isValid(), false,
    "is invalid when special char")

  Ember.run => @contact.set("phone", "")
  equal(@contact.isValid(), true,
    "is invalid when empty string")

  Ember.run => @contact.set("phone", "1112223333")
  equal(@contact.isValid(), true,
    "is valid when sequence of numbers")

  Ember.run => @contact.set("phone", "111-222-3333")
  equal(@contact.isValid(), true,
    "is valid when alternating numbers and dash")

  Ember.run => @contact.set("phone", "1-949-830-1657")
  equal(@contact.isValid(), true,
    "is valid for international format")

  Ember.run => @contact.set("phone", "1-949-830-1657:0000")
  equal(@contact.isValid(), true,
    "is valid when with extension")


test 'isValid validates email address', ->
  Ember.run => @contact.set("email", "invalid")
  equal(@contact.isValid(), false,
    "is invalid when email doesn't have @")

  Ember.run => @contact.set("email", "invalid@place")
  equal(@contact.isValid(), false,
    "is invalid when email doesn't have address following @")

  Ember.run => @contact.set("email", "@place.com")
  equal(@contact.isValid(), false,
    "is valid when email doesn't have anything preceeding @")

  Ember.run => @contact.set("email", "shane@grezha.com")
  equal(@contact.isValid(), true,
    "is valid when email is an email")

  Ember.run => @contact.set("email", "")
  equal(@contact.isValid(), true,
    "is valid when email is empty")


test 'isDuplicate', ->
  equal(@contact.isDuplicate(), false,
    "isn't true by default")

  Ember.run =>
    @store().createRecord('contact', name: "Fran")
    @contact.set("name", "Fran")
  ok(@contact.isDuplicate(),
    "is true when contact has same name as another Contact")


test 'daysUntilBirthday', ->
  Ember.run => @contact.set("birthday", null)
  equal(@contact.get("daysUntilBirthday"), null,
    "is null if birthday is null")

  Ember.run => @contact.set("birthday", moment().year(1970))
  equal(@contact.get("daysUntilBirthday"), 0,
    "is 0 for the birthday boy!")

  leapYearBirthday = moment().year(1999).add(363, 'days').startOf('day')
  Ember.run => @contact.set("birthday", leapYearBirthday)
  equal(@contact.get("daysUntilBirthday"), 363,
    "is the days until next birthday, even if it's next year")

  Ember.run =>
    @contact.set("birthday",
      moment().year(2013).add(2, 'days').startOf('day'))
  equal(@contact.get("daysUntilBirthday"), 2,
    "is the days until next birthday")


test 'sortedConnections', ->
  Ember.run =>
    equal(@contact.get('sortedConnections.length'), 0,
      "is empty when no connections")

    connections = @contactWithConnections.get('connections')
    connections.objectAt(0).setProperties(
      note: "occurs second", occurredAt: new Date(2014, 9, 7))
    connections.objectAt(1).setProperties(
      note: "occurs first", occurredAt: new Date(2014, 9, 6))
    connections.objectAt(2).setProperties(
      note: "occurs third", occurredAt: new Date(2014, 9, 8))

    sortedConnections = @contactWithConnections.get('sortedConnections')
    equal(sortedConnections.get('length'), 3,
      "have the same number of connections")
    deepEqual(
      sortedConnections.mapBy('note'),
      ["occurs third", "occurs second", "occurs first"],
      "are in reverse time order")


test 'lastSeen', ->
  Ember.run =>
    equal(@contact.get('lastSeen'), @contact.get('createdAt'),
      "is createdAt time when no connections")

    connections = @contactWithConnections.get('connections')
    connections.objectAt(1).set('occurredAt', new Date(2014, 9, 6))
    deepEqual(@contactWithConnections.get('lastSeen'), new Date(2014, 9, 6),
      "is occurredAt from most recent connection")


test 'unassigned', ->
  Ember.run =>
    equal(@contact.get("unassigned"), true)
    @contact.set('user', @user)
    equal(@contact.get("unassigned"), false)

