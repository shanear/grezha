`import Ember from 'ember'`

zeroPad = (num, places) ->
  zero = places - num.toString().length + 1
  Array(+(zero > 0 && zero)).join("0") + num

DateFieldComponent = Ember.Component.extend
  requireYear: true
  includeTime: false
  days: [1..31]
  nullYear: 1900

  months: [
    {id : 1, name : "Jan"},
    {id : 2, name : "Feb"},
    {id : 3, name : "Mar"},
    {id : 4, name : "Apr"},
    {id : 5, name : "May"},
    {id : 6, name : "Jun"},
    {id : 7, name : "Jul"},
    {id : 8, name : "Aug"},
    {id : 9, name : "Sep"},
    {id : 10, name : "Oct"},
    {id : 11, name : "Nov"},
    {id : 12, name : "Dec"}
  ]

  years: [(new Date().getFullYear())..1950]
  hours:
    [1..12].map (hours)-> zeroPad(hours, 2)
  minutes:
    (x for x in [0..55] by 5).map (minutes)-> zeroPad(minutes, 2)
  amPm: ["am", "pm"]

  transformToAmPmHours: (hours)-> hours % 12 || 12
  roundMinutes: (minutes)-> Math.ceil(minutes / 5) * 5
  selectedHourOfDay: Ember.computed "selectedHour", "selectedAmPm", ->
    (@get('includeTime') &&
      (if @get('selectedAmPm') == 'am' then 0 else 12) +
      (if @get('selectedHour') == '12' then 0 else parseInt(@get('selectedHour'))))

  date: ((key, value, previousValue)->
    if arguments.length > 1 && value
      @set('selectedMonth', value.getMonth() + 1)
      @set('selectedYear', value.getFullYear())
      @set('selectedDay', value.getDate())
      @set('selectedHour', zeroPad(@transformToAmPmHours(value.getHours()), 2))
      @set('selectedMinute', zeroPad(@roundMinutes(value.getMinutes()), 2))
      @set('selectedAmPm', if value.getHours() < 11 then "am" else "pm")

    if @get('selectedMonth') && @get("selectedDay") && (!@get('requireYear') || @get("selectedYear"))
      new Date(
        @get('selectedYear') || this.nullYear,
        @get('selectedMonth') - 1,
        @get('selectedDay'),
        @get('selectedHourOfDay') || 0,
        @get('selectedMinute') || 0
      )
  ).property("selectedMonth", "selectedYear", "selectedDay", "selectedHourOfDay", "selectedMinute")

`export default DateFieldComponent`