`import DS from 'ember-data'`

Connection = DS.Model.extend
  contact: DS.belongsTo('contact')
  note: DS.attr('string')
  occurredAt: DS.attr('date')
  mode: DS.attr('string')

Connection.reopenClass
  MODES: ['In Person', 'Email', 'Phone', 'Text']

`export default Connection`
