App.AutocompleteFieldComponent = Ember.Component.extend
  suggestions: []
  highlightedIndex: -1
  isAutocompleting: false
  pinnedSuggestion: null
  forceSelection: false
  queryProperty: ""
  subtextProperty: ""

  setInitialSelection: (->
    if @get("forceSelection")
      @setHighlightedIndex(0)
      @set('isAutocompleting', true)
  ).on('init')

  activeSuggestions: (->
    query = @get("value") || ""

    result = @suggestions.filter((suggestion)=>
      suggestion.get(@get('queryProperty')).toUpperCase().substring(0,query.length) == query.toUpperCase()
    )

    if @get("pinnedSuggestion")?
      result = result.slice(0, 4)
      result.pushObject(Ember.Object.create(isDefault: true))
      result
    else
      result.slice(0, 5)
  ).property('value', 'suggestions')

  reset: (->
    if @get("forceSelection")
      @setHighlightedIndex(0)
      @set('isAutocompleting', true)
    else
      @setHighlightedIndex(-1)

    @set('isAutocompleting', true) if @get("value")?
  ).observes('value', 'suggestions')

  setHighlightedIndex: (index)->
    @get("activeSuggestions").forEach (suggestion)->
      suggestion.set("isHighlighted", false) if suggestion?

    newHighlightedSuggestion = @get("activeSuggestions").objectAt(index)

    @set("highlightedIndex", index)
    newHighlightedSuggestion.set("isHighlighted", true) if newHighlightedSuggestion

  actions:
    highlightSuggestion: (suggestion)->
      index = @get('activeSuggestions').indexOf(suggestion)
      @setHighlightedIndex(index)

    selectHighlightedSuggestion: ->
      suggestion = @get("activeSuggestions").objectAt(@get("highlightedIndex"))

      @send('selectSuggestion', suggestion) if suggestion?

    selectSuggestion: (suggestion)->
      if suggestion.get("isDefault")
        suggestion = null
      else
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
