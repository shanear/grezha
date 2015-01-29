`import DS from 'ember-data'`

Person = DS.Model.extend
  name: DS.attr('string')
  contactInfo: DS.attr('string')
  role: DS.attr('string')
  notes: DS.attr('string')
  errors: []

  isValid: ->
    errors = []
    if @get('name') == undefined || $.trim(@get('name')).length < 1
      errors.push 'Name is required.'
    if @get('role') == undefined || $.trim(@get('role')).length < 1
      errors.push "Role is required."
    @set('errors', errors)
    if @get('errors').length > 0
      return false
    return true

`export default Person`