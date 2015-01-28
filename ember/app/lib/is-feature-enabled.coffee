isFeatureEnabled = (feature, organization)->
  return true if organization == 'Grezha Admin'

  if feature == 'vehicles'
    if organization == 'Daughters of Bulgaria'
      return true

  if feature == 'addedOn'
    if organization == 'Contra Costa Reentry Network'
      return true

  return false

`export default isFeatureEnabled`