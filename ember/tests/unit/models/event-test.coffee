`import Ember from 'ember'`
`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel('event', 'Event Model', needs: ['model:program'])

test 'isValid validates name', ->
  contact = @subject({name: "Tony Danza"})
  ok(contact.get('isValid'), "is valid with name")

  Ember.run => contact.set("name", "")
  equal(contact.get('isValid'), false, "isn't valid with empty name")

  Ember.run => contact.set("name", "    ")
  equal(contact.get('isValid'), false, "isn't valid with whitespace name")

  Ember.run => contact.set("name", null)
  equal(contact.get('isValid'), false, "isn't valid with undefined name")
