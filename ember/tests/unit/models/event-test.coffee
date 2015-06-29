`import Ember from 'ember'`
`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel('event', 'Event Model', needs: ['model:program', 'model:participation', 'model:contact'])

test 'isValid validates name', ->
  contact = @subject({name: "Tony Danza"})
  ok(contact.get('isValid'), "is valid with name")

  Ember.run => contact.set("name", "")
  equal(contact.get('isValid'), false, "isn't valid with empty name")

  Ember.run => contact.set("name", "    ")
  equal(contact.get('isValid'), false, "isn't valid with whitespace name")

  Ember.run => contact.set("name", null)
  equal(contact.get('isValid'), false, "isn't valid with undefined name")


test 'isUpcoming', ->
  contact = @subject({startsAt: moment().subtract(1, 'hours')})
  equal(contact.get('isUpcoming'), false)

  Ember.run => contact.set('startsAt', moment().add(1, 'hours'))
  equal(contact.get('isUpcoming'), true)
