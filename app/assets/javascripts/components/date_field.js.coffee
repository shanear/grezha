App.DateFieldComponent = Ember.TextField.extend
  classNames: ["form-control"]

  applyDatePicker: (->
    @$().datepicker().on "changeDate", (e) =>
      @set("date", e.date)
  ).on("didInsertElement")

  date: ((key, date) ->
    if date
      @set('value', moment(date).format("MM/DD/YYYY"))
    else
      value = @get('value')
      if value
        date = moment(value).toDate()
      else
        date = null
    date
  ).property('value')
