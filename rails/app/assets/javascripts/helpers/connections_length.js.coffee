Ember.Handlebars.registerBoundHelper 'connectionsLength', ((connections, options) ->
  return 0 unless connections?
  connections.filterBy('mode', options.hash.mode).get('length')
), "@each"