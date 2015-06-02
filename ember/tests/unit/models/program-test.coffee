`import Ember from 'ember'`
`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel('program', 'Program Model')

test 'slug based on name', ->
  program = @subject({name: "Dragonball Z Club"})
  equal(program.get('slug'), "dragonball-z-club")

test 'slug strips invalid URL characters', ->
  program = @subject({name: "Salt & Pepper Fan Club"})
  equal(program.get('slug'), "salt-pepper-fan-club")
