App.Contact = DS.Model.extend
  name: DS.attr('string')
  city: DS.attr('string')
  bio: DS.attr('string')
  lastSeen: DS.attr('date')
  birthday: DS.attr('date')
  pictureUrl: DS.attr('string')
  connections: DS.hasMany('connection')

  sortedConnections: (->
    @get('connections').toArray().sort (a, b)->
      b.get('date') - a.get('date')
  ).property('connections.@each.isLoaded')