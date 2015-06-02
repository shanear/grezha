`import DS from 'ember-data'`
`import Ember from 'ember'`

Program = DS.Model.extend
  name: DS.attr('string')
  slug: Ember.computed 'name', ->
    this.get('name').replace(/[^A-Za-z0-9-\s]/, '').replace(/\s+/g, '-').toLowerCase()


`export default Program`