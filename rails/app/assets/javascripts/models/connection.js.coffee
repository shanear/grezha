App.Connection = DS.Model.extend
  contact: DS.belongsTo('contact')
  note: DS.attr('string')
  occurredAt: DS.attr('date')
  mode: DS.attr('string')
  errors: []

  isValid: ->
    errors = []
    if @get('note') == undefined || (@get('note').replace /[ ]/g, '').length < 1
      errors.push 'Note cannot be blank.'
    if @get('occurredAt') == undefined
      errors.push 'Date cannot be blank.'
    @set('errors', errors)
    if @get('errors').length > 0
      return false
    return true

App.Connection.reopenClass
  MODES: ['In Person', 'Email', 'Phone', 'Text']