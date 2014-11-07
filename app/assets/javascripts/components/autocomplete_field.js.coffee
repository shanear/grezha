App.AutocompleteFieldComponent = Ember.Component.extend
  suggestions: []
  highlightedIndex: -1

  isAutocompleting: (->
    !@get('hideAutocomplete') && @get('value')
  ).property("value", "hideAutocomplete")

  activeSuggestions: (->
    query = @get("value") || ""

    @suggestions.filter((suggestion)=>
      suggestion.get(@get('queryProperty')).toUpperCase().substring(0,query.length) == query.toUpperCase()
    ).slice(0, 5)
  ).property('value')

  reset: (->
    @setHighlightedIndex(-1)
    @set('hideAutocomplete', false)
  ).observes('value')

  setHighlightedIndex: (index)->
    @get("activeSuggestions").forEach (relationship)->
      relationship.set("isHighlighted", false)

    newHighlightedRelationship = @get("activeSuggestions").objectAt(index)

    @set("highlightedIndex", index)
    newHighlightedRelationship.set("isHighlighted", true) if newHighlightedRelationship

  actions:
    highlightAutocomplete: (relationship)->
      index = @get('activeSuggestions').indexOf(relationship)
      @setHighlightedIndex(index)

    autocomplete: (suggestion)->
      if suggestion?
        suggestion = @get("activeSuggestions").objectAt(@get("highlightedIndex"))

      if suggestion?
        selectedValue = suggestion.get(@get("queryProperty"))
        @set("hideAutocomplete", true)
        @set("value", selectedValue)
        @sendAction("onSelect", suggestion)

    moveAutocompleteHighlightDown: ->
      @set('hideAutocomplete', false)

      if(@get("highlightedIndex") + 1 < @get("activeSuggestions.length"))
        newIndex = @get("highlightedIndex") + 1
        @setHighlightedIndex(newIndex)

    moveAutocompleteHighlightUp: ->
      if(@get("highlightedIndex") > -1)
        newIndex = @get("highlightedIndex") - 1
        @setHighlightedIndex(newIndex)

    hideAutocomplete: ->
      @set('hideAutocomplete', true)
      @setHighlightedIndex(-1)
