App.FocusedTextareaComponent = Ember.TextArea.extend
  didInsertElement: ->
    @$().focus()

