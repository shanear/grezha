`import DS from 'ember-data'`

Registration = DS.Model.extend
  createdAt: DS.attr('date', defaultValue: -> new Date() )
  event: DS.belongsTo('event', async: true)
  contact: DS.belongsTo('contact', async: true)

`export default Registration`