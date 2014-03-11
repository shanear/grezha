Ember.Handlebars.helper 'formatDate', (date) ->
  return moment(date).format('MMMM Do YYYY')

Ember.Handlebars.helper 'formatDayOfYear', (date) ->
  return moment(date).format('MMMM Do')

Ember.Handlebars.helper 'formatShortDate', (date) ->
  return moment(date).format('MMM DD')

Ember.Handlebars.helper 'formatYear', (date) ->
  return moment(date).format('YYYY')

