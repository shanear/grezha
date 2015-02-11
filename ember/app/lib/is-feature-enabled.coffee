`import config from '../config/environment'`


isFeatureEnabled = (feature, organization)->
  return true if organization == 'Grezha Admin'
  return true if config.environment == 'development'

  if feature == 'vehicles'
    if organization == 'Daughters of Bulgaria'
      return true

  if feature == 'addedOn'
    if organization == 'Contra Costa Reentry Network'
      return true

  return false

`export default isFeatureEnabled`