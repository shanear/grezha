Ember.Handlebars.helper 'breaklines', (text) ->
  text = Ember.Handlebars.Utils.escapeExpression(text);
  text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
  new Ember.Handlebars.SafeString(text);


