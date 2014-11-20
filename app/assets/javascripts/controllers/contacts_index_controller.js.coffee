App.ContactsIndexController = Ember.Controller.extend
  currentYearConnections: Ember.computed.alias("connectionsByMonth.lastObject")
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

  earliestConnection: ->
    @get('allConnections').reduce (minimum, current) ->
      if !minimum? || (minimum.get("occurredAt") > current.get("occurredAt"))
        return current
      else
        return minimum