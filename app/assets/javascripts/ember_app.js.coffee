Application = Ember.Application.extend
  state: 'up'
  online: true
  readonly: Ember.computed.not('online')

Application.initializer
  name: "start connectivity checks"
  initialize: (container, application)->
    setInterval (->
      ping = Ember.$.get('/ping')
      ping.done -> application.set('online', true)
      ping.fail -> application.set('online', false)
    ), 10000

window.App = Application.create
  rootElement: '#ember-app'

