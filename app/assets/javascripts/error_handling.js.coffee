# Ember errors
Ember.onerror = (e)->
  Rollbar.error(e) if Rollbar?

# Promise errors
Ember.RSVP.configure 'onerror', (e)->
  error = App.processError(e)

  if error
    Rollbar.error(error) if Rollbar?
    console.error(e);
    console.error(error.message);
    console.error(error.stack);

App.processError = (error)->
  return null if error.status == 404
  return error
