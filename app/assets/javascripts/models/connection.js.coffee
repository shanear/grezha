App.Connection = DS.Model.extend
  contact: DS.belongsTo('contact')
  note: DS.attr('string')
  occurredAt: DS.attr('date')

  foo: ->
    alert "wtf"
  
  errors: []
  isValid: ->
    errors = []
    if @get('note') == undefined || (@get('note').replace /[ ]/g, '').length < 1
      errors.push 'Note cannot be blank.'
    @set('errors', errors)
    if @get('errors').length > 0
      return false
    return true

