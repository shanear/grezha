Handlebars.registerHelper 'formatDate', (date) ->
  return moment().format('MMMM Do YYYY')

Handlebars.registerHelper 'formatDayOfYear', (date) ->
  return moment().format('MMMM Do')
