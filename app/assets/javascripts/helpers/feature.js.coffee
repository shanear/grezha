Ember.Handlebars.registerHelper 'feature', (featureName, options)->
  featureEnabled = false

  if App.organizationId == '2'
    featureEnabled = true

  else if featureName == 'vehicles'
    featureEnabled = true if App.organizationId == '1'

  if featureEnabled
    return options.fn(this)
