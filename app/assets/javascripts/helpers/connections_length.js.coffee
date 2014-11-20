Ember.Handlebars.registerBoundHelper 'connectionsLength', ((connections, options) ->
  connections.filterBy('mode', options.hash.mode).get('length')
), "@each"