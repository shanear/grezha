`import Ember from 'ember'`

formatBirthday = Ember.Handlebars.makeBoundHelper (date) ->
    if date.getFullYear() != 1900
      return moment(date).format("MMMM Do YYYY")
    else
      return moment(date).format("MMMM Do")

`export default formatBirthday`

