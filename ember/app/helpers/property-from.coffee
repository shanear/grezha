`import Ember from 'ember'`

PropertyHelper = Ember.Handlebars.makeBoundHelper (propertyName, model)->
  return model.get(propertyName)

`export default PropertyHelper`
