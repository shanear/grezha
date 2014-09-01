App.Relationship = DS.Model.extend
  contact: DS.belongsTo('contact')
  name: DS.attr('string')
  contactInfo: DS.attr('string')
  relationshipType: DS.attr('string')
  notes: DS.attr('string')
  errors: []

  isValid: ->
    errors = []
    if @get('name') == undefined || $.trim(@get('name')).length < 1
      errors.push 'Relationship must have a name.'
    if @get('relationshipType') == undefined || $.trim(@get('relationshipType')).length < 1
      errors.push "Relationship type is required."
    @set('errors', errors)
    if @get('errors').length > 0
      return false
    return true
