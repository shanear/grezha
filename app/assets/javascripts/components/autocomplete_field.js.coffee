App.AutocompleteFieldComponent = Ember.TextField.extend
  keyDown: (event)->
    if(event.keyCode == 38)
      @sendAction("upArrow")
    else if(event.keyCode == 40)
      @sendAction("downArrow")
    else if(event.keyCode == 13)
      @sendAction("enter")
    @_super(event)

