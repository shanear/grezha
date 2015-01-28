`import Ember from 'ember'`

breakLines = (text) ->
  text = text.replace(/(\r\n|\n|\r)/gm, '<br/>');
  new Ember.Handlebars.SafeString(text)

`export default breakLines`
