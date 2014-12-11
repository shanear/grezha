`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'contact', 'Contact'

test '.daysUntilBirthday when birthday is null', ->
  ok(1)
###
  contact = @subject()
  Ember.run -> contact.set("birthday", null)
  equal(contact.get("daysUntilBirthday"), null,
    "daysUntilBirthday should be null if birthday is null")

test ".daysUntilBirthday when today is contact's birthday", ->
  contact = @subject()
  Ember.run -> contact.set("birthday", moment().year(1970))
  equal(contact.get("daysUntilBirthday"), 0,
    "daysUntilBirthday should be 0 for the birthday boy!")

test ".daysUntilBirthday when birthday is next calendar year", ->
  contact = @subject()
  leapYearBirthday = moment().year(1999).add(363, 'days').startOf('day')
  Ember.run -> contact.set("birthday", leapYearBirthday)
  equal(contact.get("daysUntilBirthday"), 362,
    "daysUntilBirthday should be the days until next birthday," +
    " expected 362 but was " + contact.get("daysUntilBirthday"))

test ".daysUntilBirthday when birthday is this calendar year", ->
  contact = @subject()
  Ember.run ->
    contact.set("birthday",
      moment().year(2012).add(2, 'days').startOf('day'))
  equal(contact.get("daysUntilBirthday"), 2,
    "daysUntilBirthday should be the days until next birthday")
###