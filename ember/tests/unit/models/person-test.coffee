`import Ember from 'ember'`
`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'person', 'Person Model',
  setup: ->
    stop()
    Ember.run =>
      @store().find('person', 'base').then (person)=>
        @person = person
        start()

test 'isValid', ->
  equal(@person.isValid(), true, "Person is valid with valid attributes")

  Ember.run => @person.set("name", "")
  equal(@person.isValid(), false, "Person isn't valid with empty name")

  Ember.run => @person.set("name", "    ")
  equal(@person.isValid(), false, "Person isn't valid with whitespace name")

  Ember.run => @person.set("name", undefined)
  equal(@person.isValid(), false, "Person isn't valid with undefined name")

  Ember.run => @person.set("name", "Shanze")
  Ember.run => @person.set("role", "")
  equal(@person.isValid(), false, "Role isn't valid when empty")

  Ember.run => @person.set("role", "    ")
  equal(@person.isValid(), false, "Role isn't valid when blank")

  Ember.run => @person.set("role", undefined)
  equal(@person.isValid(), false, "Role isn't valid when undefined")
