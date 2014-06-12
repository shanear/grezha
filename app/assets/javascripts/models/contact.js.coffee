App.Contact = DS.Model.extend
  name: DS.attr('string')
  city: DS.attr('string')
  bio: DS.attr('string')
  birthday: DS.attr('date')
  createdAt: DS.attr('date',
    defaultValue: -> new Date()
  )
  pictureUrl: DS.attr('string',
    defaultValue: -> AssetPaths.defaultContactAvatar
  )

  connections: DS.hasMany('connection', async: true)

  sortedConnections: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      content: @get('connections')
      sortProperties: ['occurredAt']
      sortAscending: false
  ).property('connections.@each')

  lastSeen: (->
    latestConnection = @get('sortedConnections.lastObject')

    if(latestConnection)
      latestConnection.get('occurredAt')
    else
      @get('createdAt')
  ).property('connections.@each')

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