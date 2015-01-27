`import Ember from 'ember'`

Ember.Test.registerHelper 'contains', (app, selector, text)->
  content = findWithAssert(selector).html()
  regex = new RegExp(text)
  return regex.test(content)
