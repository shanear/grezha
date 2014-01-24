App.DateFieldComponent = Ember.TextField.extend
  classNames: ["form-control"]

  dateText: ((key, value) ->
    if value == undefined
      if(date = @get("date"))
        date.format('MM/DD/YYYY')
      else
        ""

    else
      date = moment(value)
      if date.isValid?
        @set "date", date
      else
        @set "date", null
  ).property()

  valueBinding: "dateText"

  applyDatePicker: (->
    @$().datepicker().on "changeDate", (e) =>
      @set("date", moment(e.date) )
  ).on("didInsertElement")