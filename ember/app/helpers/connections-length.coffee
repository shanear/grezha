`import Ember from 'ember'`

connectionsLength = Ember.Handlebars.makeBoundHelper (
  (connections, options) ->
    return 0 unless connections?
    connections.filterBy('mode', options.hash.mode).get('length')
), "@each"

`export default connectionsLength`