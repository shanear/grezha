App.Contact = DS.Model.extend
  name: DS.attr('string')
  city: DS.attr('string')
  bio: DS.attr('string')
  birthday: DS.attr('date')
  phone: DS.attr('string')
  memberId: DS.attr('string')
  createdAt: DS.attr('date',
    defaultValue: -> new Date()
  )
  pictureUrl: DS.attr('string',
    defaultValue: -> AssetPaths.defaultContactAvatar
  )

  connections: DS.hasMany('connection', async: true)
  relationships: DS.hasMany('relationship', async: true)
  user: DS.belongsTo('user')

  sortedRelationships: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      content: @get('relationships')
      sortProperties: ['name']
      sortAscending: false
  ).property('relationships.@each')

  sortedConnections: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      content: @get('connections')
      sortProperties: ['occurredAt']
      sortAscending: false
  ).property('connections.@each')

  status: (->
    latestConnection = @get('lastSeen')
    if(latestConnection>= moment().subtract('months', '6').toDate())
      return 'active'
    else
      return 'inactive'
  ).property('connections.@each')

  lastSeen: (->
    latestConnection = @get('sortedConnections.firstObject')

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

    if App.hasFeature('memberId')
      if @get('memberId') == undefined || (@get('memberId').replace /[ ]/g, '').length < 1
        errors.push 'member id cannot be blank.'

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
