`import DS from 'ember-data'`
`import Ember from 'ember'`
`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel('contact', 'Contact Model'
  setup: ->
    @store().unloadAll('contact')

    @contact = Ember.run =>
      @store().createRecord(
        'contact', { name: 'Smurfy' }
      )
)

test "createdAt defaults to now", ->
  now = new Date()
  timekeeper.freeze(now)
  @contact = Ember.run => @store().createRecord('contact')
  equal(@contact.get("createdAt"), now,
    "Created at should default to now")


test 'isValid validates name', ->
  ok(@contact.isValid(), "Contact is valid with name")

  Ember.run => @contact.set("name", "")
  equal(@contact.isValid(), false,
    "Contact isn't valid with empty name")

  Ember.run => @contact.set("name", "    ")
  equal(@contact.isValid(), false,
    "Contact isn't valid with whitespace name")

  Ember.run => @contact.set("name", null)
  equal(@contact.isValid(), false,
    "Contact isn't valid with undefined name")


test 'isValid validates phone number', ->
  Ember.run => @contact.set("phone", "invalid phone #")
  equal(@contact.isValid(), false,
    "phone # should be invalid when plain english")

  Ember.run => @contact.set("phone", "-")
  equal(@contact.isValid(), false,
    "phone # should be invalid when special char")

  Ember.run => @contact.set("phone", "")
  equal(@contact.isValid(), true,
    "phone # should be invalid when empty string")

  Ember.run => @contact.set("phone", "1112223333")
  equal(@contact.isValid(), true,
    "phone # should be valid when sequence of numbers")

  Ember.run => @contact.set("phone", "111-222-3333")
  equal(@contact.isValid(), true,
    "phone # should be valid when alternating numbers and dash")

  Ember.run => @contact.set("phone", "1-949-830-1657")
  equal(@contact.isValid(), true,
    "phone # should be valid for international format")

  Ember.run => @contact.set("phone", "1-949-830-1657:0000")
  equal(@contact.isValid(), true,
    "phone # should be valid when with extension")


test 'isDuplicate', ->
  equal(@contact.isDuplicate(), false, "Contact isn't duplicate by default")
  Ember.run =>
    @store().createRecord('contact', name: "Fran")
    @contact.set("name", "Fran")

  ok(@contact.isDuplicate(),
    "Contact is duplicate when it has same name as another Contact")


test 'daysUntilBirthday', ->
  Ember.run => @contact.set("birthday", null)
  equal(@contact.get("daysUntilBirthday"), null,
    "daysUntilBirthday should be null if birthday is null")

  Ember.run => @contact.set("birthday", moment().year(1970))
  equal(@contact.get("daysUntilBirthday"), 0,
    "daysUntilBirthday should be 0 for the birthday boy!")

  leapYearBirthday = moment().year(1999).add(363, 'days').startOf('day')
  Ember.run => @contact.set("birthday", leapYearBirthday)
  equal(@contact.get("daysUntilBirthday"), 363,
    "daysUntilBirthday should be the days until next birthday," +
    " expected 363 but was " + @contact.get("daysUntilBirthday"))

  Ember.run =>
    @contact.set("birthday",
      moment().year(2012).add(2, 'days').startOf('day'))
  equal(@contact.get("daysUntilBirthday"), 2,
    "daysUntilBirthday should be the days until next birthday," +
    " expected 2 but was " + @contact.get("daysUntilBirthday"))