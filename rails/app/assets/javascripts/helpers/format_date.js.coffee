Ember.Handlebars.helper 'formatDate', (date) ->
  return moment(date).format('MMMM Do YYYY')

Ember.Handlebars.helper 'formatShortDate', (date) ->
  return moment(date).format('MMM DD')

Ember.Handlebars.helper 'formatYear', (date) ->
  return moment(date).format('YYYY')

Ember.Handlebars.helper 'formatBirthday', (date) ->
  if date.getFullYear() != 1900
    return moment(date).format("MMMM Do YYYY")
  else
    return moment(date).format("MMMM Do")

