
Ember.Handlebars.helper 'breaklines', (text) ->
  text = Ember.Handlebars.Utils.escapeExpression(text);
  App.Helpers.breaklines(text);

