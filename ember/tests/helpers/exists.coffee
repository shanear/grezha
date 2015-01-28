`import Ember from 'ember'`

Ember.Test.registerHelper 'exists', (app, selector, text)->
  find(selector).length > 0