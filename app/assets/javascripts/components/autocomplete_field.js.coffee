App.AutocompleteFieldComponent = Ember.Component.extend
  suggestions: []
  highlightedIndex: -1
  isAutocompleting: false

  activeSuggestions: (->
    query = @get("value") || ""

    @suggestions.filter((suggestion)=>
      suggestion.get(@get('queryProperty')).toUpperCase().substring(0,query.length) == query.toUpperCase()
    ).slice(0, 5)
  ).property('value')

  reset: (->
    @setHighlightedIndex(-1)
    @set('isAutocompleting', true) if @get("value")?
  ).observes('value')

  setHighlightedIndex: (index)->
    @get("activeSuggestions").forEach (suggestion)->
      suggestion.set("isHighlighted", false)

    newHighlightedSuggestion = @get("activeSuggestions").objectAt(index)

    @set("highlightedIndex", index)
    newHighlightedSuggestion.set("isHighlighted", true) if newHighlightedSuggestion

  actions:
    highlightSuggestion: (suggestion)->
      index = @get('activeSuggestions').indexOf(suggestion)
      @setHighlightedIndex(index)

    selectSuggestion: (suggestion)->
      unless suggestion?
        suggestion = @get("activeSuggestions").objectAt(@get("highlightedIndex"))

      if suggestion?
        selectedValue = suggestion.get(@get("queryProperty"))
        @set("value", selectedValue)
        @sendAction("onSelect", suggestion)
        @set("isAutocompleting", false)

    moveHighlightDown: ->
      @set('isAutocompleting', true)

      if(@get("highlightedIndex") + 1 < @get("activeSuggestions.length"))
        newIndex = @get("highlightedIndex") + 1
        @setHighlightedIndex(newIndex)

    moveHighlightUp: ->
      if(@get("highlightedIndex") > -1)
        newIndex = @get("highlightedIndex") - 1
        @setHighlightedIndex(newIndex)

    hideSuggestions: ->
      @set('isAutocompleting', false)
      @setHighlightedIndex(-1)
