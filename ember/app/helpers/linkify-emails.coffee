`import Ember from 'ember'`
`import breakLines from 'grezha/lib/break-lines'`

LinkifyEmails = Ember.Handlebars.makeBoundHelper (text) ->
  text = Ember.Handlebars.Utils.escapeExpression(text);
  addEmailRegex = new RegExp("[A-z0-9\.]*@[A-z0-9\.]*",'ig')
  text = text.replace(addEmailRegex,
    "<a class='email-links' href=\"mailto:$&\">$&</a>")
  breakLines(text)

`export default LinkifyEmails`
