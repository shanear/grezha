`import Ember from 'ember'`

Util = {}
Util.breaklines = (text) ->
  text = text.replace(/(\r\n|\n|\r)/gm, '<br/>');
  new Ember.Handlebars.SafeString(text)

breakLines = Ember.Handlebars.makeBoundHelper (text) ->
  text = Ember.Handlebars.Utils.escapeExpression(text);
  Util.breaklines(text);

`export default breakLines`