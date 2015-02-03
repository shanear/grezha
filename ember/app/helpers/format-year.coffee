`import Ember from 'ember'`

formatYear = Ember.Handlebars.makeBoundHelper (date) ->
  return moment(date).format('YYYY')

`export default formatYear`
