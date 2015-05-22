`import DS from 'ember-data'`

Event = DS.Model.extend
  name: DS.attr('string')
  startsAt: DS.attr('date')
  location: DS.attr('string')
  notes: DS.attr('string')
  isValid: Ember.computed 'name', -> !!(@get('name') || "").trim()

`export default Event`