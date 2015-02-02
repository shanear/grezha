`import Ember from "ember"`
`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent("date-field", "Date Field Component")

test "Default date", ->
  dateField = @subject()

  ok(!dateField.get("selectedYear"))
  equal(dateField.get("selectedMonth"))
  ok(!dateField.get("selectedDay"))


test "Setting date updates selected day, month, year", ->
  dateField = @subject()

  Ember.run -> dateField.set('date', new Date(1987, 9, 6))
  equal(dateField.get("selectedYear"), 1987)
  equal(dateField.get("selectedMonth"), 10)
  equal(dateField.get("selectedDay"), 6)


test "Setting day, month, and year sets date", ->
  dateField = @subject()

  Ember.run ->
    dateField.set("selectedYear", 1929)
    dateField.set("selectedMonth", 1)
    dateField.set("selectedDay", 15)

  date = dateField.get('date')

  equal(date.getFullYear(), 1929, "Year set wrong")
  equal(date.getMonth(), 0, "Month set wrong")
  equal(date.getDate(), 15, "Day set wrong")


test "Setting year to nil still preserves month and day", ->
  dateField = @subject()

  Ember.run ->
    dateField.set("selectedYear", null)
    dateField.set("selectedMonth", 8)
    dateField.set("selectedDay", 2)
    dateField.set("requireYear", false)

  date = dateField.get('date')

  equal(date.getFullYear(), 1900, "Year set wrong")
  equal(date.getMonth(), 7, "Month set wrong")
  equal(date.getDate(), 2, "Day set wrong")


test "Setting month or day to nil, sets date to nil", ->
  dateField = @subject()

  Ember.run ->
    dateField.set("selectedYear", 2011)
    dateField.set("selectedMonth", null)
    dateField.set("selectedDay", 2)

  ok(!dateField.get('date'))

  Ember.run ->
    dateField.set("selectedYear", 2011)
    dateField.set("selectedMonth", 9)
    dateField.set("selectedDay", null)

  ok(!dateField.get('date'))

