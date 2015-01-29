`import DS from 'ember-data'`

Relationship = DS.Model.extend
  contact: DS.belongsTo('contact', async: true)
  person: DS.belongsTo('person', async: true)
  name: DS.attr('string')
  contactInfo: DS.attr('string')
  relationshipType: DS.attr('string')
  notes: DS.attr('string')

`export default Relationship`