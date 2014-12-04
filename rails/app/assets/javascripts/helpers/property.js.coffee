Ember.Handlebars.helper 'property', (propertyName, model)->
  return model.get(propertyName)
