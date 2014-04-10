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

  sortedConnections: Ember.computed.sort 'connections', (a, b)->
    b.get('date') - a.get('date')

  errors: []

  isValid: ->
    errors = []
    if @get('name') == undefined || (@get('name').replace /[ ]/g, '').length < 1
      errors.push 'Name cannot be blank.'
    else if @isDuplicate()
      errors.push "That name already exists."

    @set('errors', errors);    
    if @get('errors').length > 0
      return false
    return true


  isDuplicate: ->
    contacts = @store.all('contact')
    i = 0
    while i < contacts.get('length')
      contact = contacts.objectAt(i)
      if(contact.get('id') != @get('id') && contact.get('name') == @get('name'))
        return true
      i++
    return false