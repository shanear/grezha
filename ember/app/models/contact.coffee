`import DS from 'ember-data'`

Contact = DS.Model.extend
  isRemoteSynced: true
  name: DS.attr('string')
  role: DS.attr('string')
  city: DS.attr('string')
  bio: DS.attr('string')
  birthday: DS.attr('date')
  gender: DS.attr('string')
  phone: DS.attr('string')
  email: DS.attr('string')
  addedAt: DS.attr('date')
  createdAt: DS.attr('date',
    defaultValue: -> new Date()
  )
  connections: DS.hasMany('connection', async: true)
  relationships: DS.hasMany('relationship', async: true)
  participations: DS.hasMany('participation', async: true)
  user: DS.belongsTo('user', async: true)
  errors: []

  isDuplicate: ->
    contacts = @store.all('contact')
    i = 0
    while i < contacts.get('length')
      contact = contacts.objectAt(i)
      if(contact.get('id') != @get('id') && contact.get('name') == @get('name'))
        return true
      i++
    return false

  isValid: ->
    errors = []
    if !@get('name')? || (@get('name').replace /[ ]/g, '').length < 1
      errors.push 'Name cannot be blank.'
    else if @isDuplicate()
      errors.push "That name already exists."

    if @get('phone')? && @get('phone') isnt "" && @get('phone').match(/^\d+-?\d+-?\d+-?\d+:?\d+$/) == null
      errors.push 'Invalid phone number. Format: xxx-xxx-xxx:ext'

    if @get('email')? && @get('email') isnt "" && @get('email').match(
      /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/) == null
      errors.push "The email address you put in isn't right."

    @set('errors', errors);
    if @get('errors').length > 0
      return false
    return true

  hideConnections: Ember.computed 'role', -> @get('role') == 'volunteer'

  sortedConnections: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      content: @get('connections')
      sortProperties: ['occurredAt']
      sortAscending: false
  ).property('connections.@each')

  sortedParticipations: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      content: @get('participations')
      sortProperties: ['event.startsAt']
      sortAscending: false
  ).property('participations.@each')

  daysUntilBirthday: (->
    return null unless @get('birthday')?

    today = moment().startOf('day')
    birthday = moment(@get('birthday')).startOf("day")

    if birthday.dayOfYear() >= today.dayOfYear()
      birthday.year(today.year()).diff(today, 'days')
    else
      birthday.year(today.year() + 1).diff(today, 'days')
  ).property('birthday')

  lastSeen: (->
    latestConnection = @get('sortedConnections.firstObject')

    if(latestConnection)
      latestConnection.get('occurredAt')
    else
      @get('createdAt')
  ).property('connections.@each.occurredAt')

  unassigned: (->
    !@get('user.content')
  ).property('user')

`export default Contact`