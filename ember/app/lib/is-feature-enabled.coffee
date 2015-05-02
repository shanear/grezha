`import config from '../config/environment'`


isFeatureEnabled = (feature, organization)->
  return true if organization == 'Grezha Admin'
  return true if config.environment == 'development'

  if feature == 'vehicles'
    if organization == 'Daughters of Bulgaria'
      return true

  if feature == 'addedOn' || feature == 'fieldOp'
    if organization == 'Contra Costa Reentry Network'
      return true

  if feature == 'volunteers' || feature == 'events'
    if organization == 'City Hope'
      return true

  return false

`export default isFeatureEnabled`