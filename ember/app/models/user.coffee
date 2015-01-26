`import DS from 'ember-data'`

User = DS.Model.extend
  name: DS.attr('string')
  email: DS.attr('string')

`export default User`