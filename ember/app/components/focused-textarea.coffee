`import Ember from 'ember'`

FocusedTextareaComponent = Ember.TextArea.extend
  didInsertElement: ->
    @$().focus()

`export default FocusedTextareaComponent`

