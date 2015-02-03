`import Ember from 'ember'`

formatShortDate = Ember.Handlebars.makeBoundHelper (date) ->
  return moment(date).format('MMM DD')

`export default formatShortDate`
