`import DS from 'ember-data'`

Event = DS.Model.extend
  name: DS.attr('string')
  startsAt: DS.attr('date')
  where: DS.attr('string')
  notes: DS.attr('string')

`export default Event`