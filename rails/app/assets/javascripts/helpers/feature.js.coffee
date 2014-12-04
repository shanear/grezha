Ember.Handlebars.registerHelper 'feature', (featureName, options)->
  return options.fn(this) if App.hasFeature(featureName)
