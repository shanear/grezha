`import Ember from 'ember'`

formatTime = Ember.Handlebars.makeBoundHelper (dateTime) ->
  return moment(dateTime).format('h:mm a')

`export default formatTime`
