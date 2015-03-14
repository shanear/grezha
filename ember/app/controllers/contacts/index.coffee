`import Ember from 'ember'`
`import Connection from 'grezha/models/connection'`

ContactsIndexController = Ember.Controller.extend
  connectionModes: Connection.MODES
  selectedYear: null
  needs: ['application', 'contacts']
  allContacts: Ember.computed.alias('controllers.contacts.model')
  assignableUsers: []

  reset: ->
    @set("controllers.application.isSearchShowing", true);

  unassignedContactCount: (->
    @get('allContacts').filter((contact)->
      contact.get('unassigned')
    ).get('length')
  ).property("allContacts.@each.unassigned")

  _initSelectedYear: (->
    @set("selectedYear", @get("connectionsByMonth.lastObject.year"))
  ).observes("allConnections.@each")

  hasMultipleYears: (->
    @get("connectionsByMonth.length") > 1
  ).property("connectionsByMonth")

  hasConnections: (->
    @get("allConnections.length") > 0
  ).property("allConnections.@each")

  connectionsByMonth:(->
    earliestConnection = @earliestConnection()
    return [] unless earliestConnection?

    startDate = moment(earliestConnection.get('occurredAt'))
    current = startDate.startOf('month')
    final = moment().endOf('month')

    years = []

    while (current.isBefore(final))
      if !years.length || (years[years.length - 1].year != current.year())
        connectionsInYear = @get("allConnections").filter (connection)->
          moment(connection.get('occurredAt')).isSame(current, 'year')
        year = {year: current.year(), months: [], connections: connectionsInYear}
        years.push(year)
      else
        year = years[years.length - 1]

      connectionsInMonth = year.connections.filter (connection)->
        moment(connection.get('occurredAt')).isSame(current, 'month')

      year.months.push({name: current.format('MMM'), connections: connectionsInMonth})
      current.add(1, 'months')

    years
  ).property("allConnections.@each")

  currentYearConnections:(->
    selectedYearIndex = null
    connectionsByMonth = @get("connectionsByMonth")
    return [] unless connectionsByMonth? && @get("selectedYear")?

    for year, index in connectionsByMonth
      if year.year == @get("selectedYear")
        selectedYearIndex = index

    connectionsByMonth.objectAt(selectedYearIndex)
  ).property("allConnections.@each", "selectedYear")

  earliestConnection: ->
    @get('allConnections').reduce (minimum, current) ->
      if !minimum? || (minimum.get("occurredAt") > current.get("occurredAt"))
        return current
      else
        return minimum

  actions:
    setYear:(year) ->
      @set("selectedYear", year)

`export default ContactsIndexController`