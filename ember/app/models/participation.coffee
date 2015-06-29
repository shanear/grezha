`import DS from 'ember-data'`

Participation = DS.Model.extend
  createdAt: DS.attr('date', defaultValue: -> new Date() )
  event: DS.belongsTo('event', async: true)
  contact: DS.belongsTo('contact', async: true)

`export default Participation`