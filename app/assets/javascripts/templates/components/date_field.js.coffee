App.DatePickerComponent = Ember.TextField.extend
  applyDatePicker: ( ->
    this.$().datepicker()
  ).on('didInsertElement')
