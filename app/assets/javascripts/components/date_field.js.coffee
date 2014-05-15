App.DateFieldComponent = Ember.Component.extend
  classNames: ["form-control"]
  days: [1..31]
  months: [1..12]
  years: [2014..1950]

  date: ((key, value, previousValue)->
    if arguments.length > 1 && value
      @set('selectedMonth', value.getMonth() + 1)
      @set('selectedYear', value.getFullYear())
      @set('selectedDay', value.getDate())

    if @get('selectedMonth') && @get("selectedDay")
      new Date(@get('selectedYear'), @get('selectedMonth') - 1, @get('selectedDay'))
  ).property("selectedMonth", "selectedYear", "selectedDay")
