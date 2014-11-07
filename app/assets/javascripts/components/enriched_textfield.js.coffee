# EnrichedTextfield allows actions to be set for the
# upArrow, downArrow, and Enter events.

App.EnrichedTextfieldComponent = Ember.TextField.extend
  keyDown: (event)->
    if(event.keyCode == 38)
      @sendAction("upArrow")
    else if(event.keyCode == 40)
      @sendAction("downArrow")
    else if(event.keyCode == 13)
      @sendAction("enter")
    else if(event.keyCode == 27)
      @sendAction("escape")
    @_super(event)

