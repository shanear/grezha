`import DS from 'ember-data'`

User = DS.Model.extend
  name: DS.attr('string')
  email: DS.attr('string')
  contacts: DS.hasMany('contacts', async: true)

`export default User`