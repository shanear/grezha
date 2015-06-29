`import DS from 'ember-data'`

Event = DS.Model.extend
  name: DS.attr('string')
  startsAt: DS.attr('date')
  location: DS.attr('string')
  notes: DS.attr('string')
  program: DS.belongsTo('program', {async: true})
  participations: DS.hasMany('participations', async: true)

  isValid: Ember.computed 'name', -> !!(@get('name') || "").trim()

  isUpcoming: Ember.computed 'startsAt', ->
    moment(@get('startsAt')).isAfter()


`export default Event`