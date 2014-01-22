Ember.Handlebars.helper 'formatDate', (date) ->
  return moment(date).format('MMMM Do YYYY')

Ember.Handlebars.helper 'formatDayOfYear', (date) ->
  return moment(date).format('MMMM Do')
