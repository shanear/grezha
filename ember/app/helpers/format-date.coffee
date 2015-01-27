`import Ember from 'ember'`

formatDate = Ember.Handlebars.makeBoundHelper (date) ->
  return moment(date).format('MMMM Do YYYY')

`export default formatDate`