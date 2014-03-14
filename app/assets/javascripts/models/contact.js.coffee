App.Contact = DS.Model.extend
  name: DS.attr('string')
  city: DS.attr('string')
  bio: DS.attr('string')
  birthday: DS.attr('date')
  createdAt: DS.attr('date',
    defaultValue: -> new Date()
  )
  pictureUrl: DS.attr('string')
  connections: DS.hasMany('connection')

  lastSeen: (->
    latestConnection = @get('sortedConnections')[0]

    if(latestConnection)
      latestConnection.get('date')
    else
      @get('createdAt')
  ).property('connections.@each.isLoaded')

  sortedConnections: (->
    @get('connections').toArray().sort (a, b)->
      b.get('date') - a.get('date')
  ).property('connections.@each.isLoaded')