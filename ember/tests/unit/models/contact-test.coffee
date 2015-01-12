`import DS from 'ember-data'`
`import Ember from 'ember'`
`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel('contact')

test "createdAt defaults to now", ->
  now = new Date()
  timekeeper.freeze(now)
  equal(@subject().get("createdAt"), now)