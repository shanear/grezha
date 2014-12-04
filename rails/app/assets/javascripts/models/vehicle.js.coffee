App.Vehicle = DS.Model.extend
  licensePlate: DS.attr('string')
  usedBy: DS.attr('string')
  notes: DS.attr('string')
  errors: []

  isValid: ->
    errors = []

    if @get('licensePlate') == undefined
      errors.push 'Name is undefined'
    else if (@get('licensePlate').replace /[ ]/g, '').length < 1
      errors.push 'License plate is blank'

    if errors.length > 0
      @set('errors', errors)
      return false
    return true
