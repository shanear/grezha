`import Ember from 'ember'`
`import breakLines from '../lib/break-lines'`

breakLinesHelper = Ember.Handlebars.makeBoundHelper (text) ->
  text = Ember.Handlebars.Utils.escapeExpression(text);
  breakLines(text);

`export default breakLinesHelper`