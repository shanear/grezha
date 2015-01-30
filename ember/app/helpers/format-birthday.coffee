`import Ember from 'ember'`

formatBirthday = Ember.Handlebars.makeBoundHelper (date) ->
    return "" unless date

    if date.getFullYear() != 1900
      moment(date).format("MMMM Do YYYY")
    else
      moment(date).format("MMMM Do")

`export default formatBirthday`

