Ember.Handlebars.helper 'highlightEmails', (text) ->
  text = Ember.Handlebars.Utils.escapeExpression(text);
  addEmailRegex = new RegExp("[A-z0-9\.]*@[A-z0-9\.]*",'ig')
  text = text.replace(addEmailRegex, "<a class='email-links' href=\"mailTo:$&\">$&</a>")
  App.Helpers.breaklines(text)