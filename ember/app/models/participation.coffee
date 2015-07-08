`import DS from 'ember-data'`

Participation = DS.Model.extend
  registeredAt: DS.attr('date')
  confirmedAt: DS.attr('date')
  event: DS.belongsTo('event', async: true)
  contact: DS.belongsTo('contact', async: true)

  toDelete: false

  isRegistered: Ember.computed.notEmpty('registeredAt')
  isConfirmed: Ember.computed.notEmpty('confirmedAt')

`export default Participation`