`import DS from 'ember-data'`

Participation = DS.Model.extend
  registeredAt: DS.attr('date')
  confirmedAt: DS.attr('date')
  event: DS.belongsTo('event', async: true)
  contact: DS.belongsTo('contact', async: true)

  confirmed: false
  isRegistered: Ember.computed.notEmpty('registeredAt')

`export default Participation`