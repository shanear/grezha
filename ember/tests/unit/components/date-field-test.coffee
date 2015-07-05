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

  Ember.run -> dateField.set('date', new Date(1987, 9, 6, 0))
  equal(dateField.get("selectedYear"), 1987)
  equal(dateField.get("selectedMonth"), 10)
  equal(dateField.get("selectedDay"), 6)
  equal(dateField.get("selectedHour"), 12)


test "Setting date updates selected hour and minute", ->
  dateField = @subject()

  Ember.run -> dateField.set('date', new Date(1987, 9, 6, 3, 3))
  equal(dateField.get("selectedHour"), "03")
  equal(dateField.get("selectedMinute"), "05")


test "Setting date updates selected am/pm", ->
  dateField = @subject()

  Ember.run -> dateField.set('date', new Date(1987, 9, 6, 16))
  equal(dateField.get("selectedHour"), "04")
  equal(dateField.get("selectedAmPm"), "pm")

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


test "Setting time sets date & time", ->
  dateField = @subject(includeTime: true)

  Ember.run ->
    dateField.set("selectedYear", 1929)
    dateField.set("selectedMonth", 1)
    dateField.set("selectedDay", 15)
    dateField.set("selectedHour", "02")
    dateField.set("selectedMinute", "40")
    dateField.set("selectedAmPm", "pm")

  date = dateField.get('date')

  equal(date.getHours(), 14, "Hour set wrong")
  equal(date.getMinutes(), 40, "Minute set wrong")


test "Setting time to 12 am works", ->
  dateField = @subject(includeTime: true)

  Ember.run ->
    dateField.set("selectedYear", 1929)
    dateField.set("selectedMonth", 1)
    dateField.set("selectedDay", 15)
    dateField.set("selectedHour", "12")
    dateField.set("selectedMinute", "00")
    dateField.set("selectedAmPm", "am")

  date = dateField.get('date')

  equal(date.getHours(), 0, "Hour set wrong")
  equal(date.getMinutes(), 0, "Minute set wrong")


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

