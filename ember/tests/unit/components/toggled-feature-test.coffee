`import Ember from "ember"`
`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent('toggled-feature')

test 'Grezha Admin features', ->
  component = this.subject()

  Ember.run =>
    component.set('session', {organization: 'Grezha Admin'})
    component.set('name', 'anyOleFeature')

  ok(this.$().hasClass('enabled'))


test 'Contra Costa features', ->
  component = this.subject()

  Ember.run =>
    component.set('session',
      {organization: 'Contra Costa Reentry Network'})
    component.set('name', 'anyOleFeature')

  ok(this.$().hasClass('disabled'),
    "should be disabled by default")

  Ember.run => component.set('name', 'addedOn')
  ok(this.$().hasClass('enabled'),
    "should have 'addedOn' feature enabled")


test 'Daughters of Bulgaria features', ->
  component = this.subject()

  Ember.run =>
    component.set('session',
      {organization: 'Daughters of Bulgaria'})
    component.set('name', 'anyOleFeature')

  ok(this.$().hasClass('disabled'),
    "should be disabled by default")

  Ember.run => component.set('name', 'vehicles')
  ok(this.$().hasClass('enabled'),
    "should have 'vehicles' feature enabled")


test 'City Hope features', ->
  component = this.subject()

  Ember.run =>
    component.set('session', {organization: 'City Hope'})
    component.set('name', 'faily-feature-mongodb')

  ok(this.$().hasClass('disabled'),
    "should be disabled for unknown features")

  Ember.run =>
    component.set('name', 'volunteers')

  ok(this.$().hasClass('enabled'),
    "should have volunteers enabled")


