`import Ember from 'ember'`

formatDate = Ember.Handlebars.makeBoundHelper (date) ->
  return moment(date).format('dddd, MMM DD')

`export default formatDate`