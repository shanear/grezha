App.DateFieldComponent = Ember.Component.extend
  days: [1..31]

  months: [
    {id : 1
    name : "Jan"},
    {id : 2,
    name : "Feb"},
    {id : 3
    name : "Mar"},
    {id : 4,
    name : "Apr"},
    {id : 5
    name : "May"},
    {id : 6,
    name : "Jun"},
    {id : 7
    name : "Jul"},
    {id : 8,
    name : "Aug"},
    {id : 9,
    name : "Sep"},
    {id : 10,
    name : "Oct"},
    {id : 11,
    name : "Nov"},
    {id : 12,
    name : "Dec"}
  ]

  years: [2014..1950]

  date: ((key, value, previousValue)->
    if arguments.length > 1 && value
      @set('selectedMonth', value.getMonth() + 1)
      @set('selectedYear', value.getFullYear())
      @set('selectedDay', value.getDate())

    if @get('selectedMonth') && @get("selectedDay")
      new Date(@get('selectedYear'), @get('selectedMonth') - 1, @get('selectedDay'))
  ).property("selectedMonth", "selectedYear", "selectedDay")
