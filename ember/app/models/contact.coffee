`import DS from 'ember-data'`

Contact = DS.Model.extend
  name: DS.attr('string')
  city: DS.attr('string')
  bio: DS.attr('string')
  birthday: DS.attr('date')
  phone: DS.attr('string')
  addedAt: DS.attr('date')
  createdAt: DS.attr('date',
    defaultValue: -> new Date()
  )

`export default Contact`