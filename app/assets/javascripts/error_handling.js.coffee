# Ember errors
Ember.onerror = (e)->
  Rollbar.error("Ember error: ", e) if Rollbar

# Promise errors
Ember.RSVP.configure 'onerror', (e)->
  if(error = processError(e))
    Rollbar.error(error) if Rollbar
    console.error(error.message);
    console.error(error.stack);

App.processError = (error)->
  return null if error.status == 404
  return error
