moduleForComponent("autocomplete-field", "Autocomplete Field Component")

Person = Ember.Object.extend({})

pringles = Person.create(name: "Pringles")
suggestions = [
  Person.create(name: "Peipeipei"),
  Person.create(name: "Popeye"),
  Person.create(name: "Sophjie"),
  Person.create(name: "Pat"),
  pringles,
  Person.create(name: "PumpkinRamen"),
  Person.create(name: "Prussik")
]

test "activeSuggestions filters based on value", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "pr"
    queryProperty: "name"
  )

  equal(autocompleteField.get("activeSuggestions.length"), 2, "Entering 'pr' should have 2 suggestions")

  autocompleteField.set("value", "T")
  equal(autocompleteField.get("activeSuggestions.length"), 0, "Entering 'T' should have 0 suggestions")


test "activeSuggestions is limited to 5", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "p"
    queryProperty: "name"
  )

  equal(autocompleteField.get("activeSuggestions.length"), 5, "activeSuggestions should be limited to 5")


test "activeSuggestions always contains default suggestion if present", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "P"
    queryProperty: "name"
    pinnedSuggestion: "something"
  )

  ok(autocompleteField.get("activeSuggestions.lastObject.isDefault"),
    "Last element in activeSuggestions should be the default suggestion.")


test "isAutocompleting is true and pinnedSuggestio is selected by default if forceSelection", ->
  autocompleteField = @subject(
    suggestions: suggestions
    queryProperty: "name"
    forceSelection: true
    pinnedSuggestion: "something"
  )

  ok(autocompleteField.get("activeSuggestions.firstObject.isHighlighted"),
    "isHighlighted should be set to true on default suggestion")
  equal(autocompleteField.get("highlightedIndex"), 0,
    "Highlighted index should be 0 but is " + autocompleteField.get("highlightedIndex"))
  equal(autocompleteField.get("isAutocompleting"), true,
    "isAutocompleting should be true but is " + autocompleteField.get("isAutocompleting"))


test "moveHighlightDown sets next selection", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "pr"
    queryProperty: "name"
  )

  autocompleteField.send("moveHighlightDown")
  ok(pringles.get("isHighlighted"))
  equal(autocompleteField.get("highlightedIndex"), 0)

  autocompleteField.send("moveHighlightDown")
  ok(!pringles.get("isHighlighted"))
  equal(autocompleteField.get("highlightedIndex"), 1)


test "moveHighlightDown doesn't move past final suggestion", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "pr"
    queryProperty: "name"
  )

  autocompleteField.send("moveHighlightDown")
  autocompleteField.send("moveHighlightDown")
  equal(autocompleteField.get("highlightedIndex"), 1)
  autocompleteField.send("moveHighlightDown")
  equal(autocompleteField.get("highlightedIndex"), 1)


test "moveHighlightDown sets isAutocompleting", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: ""
    queryProperty: "name"
  )

  ok(!autocompleteField.get("isAutocompleting"))
  autocompleteField.send("moveHighlightDown")
  ok(autocompleteField.get("isAutocompleting"))


test "moveHighlightUp sets previous highlighted suggestion", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "pr"
    queryProperty: "name"
  )

  autocompleteField.send("moveHighlightDown")
  equal(autocompleteField.get("highlightedIndex"), 0)
  autocompleteField.send("moveHighlightUp")
  equal(autocompleteField.get("highlightedIndex"), -1)


test "moveHighlightUp doesn't set index less than -1", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "pr"
    queryProperty: "name"
  )

  autocompleteField.send("moveHighlightDown")
  equal(autocompleteField.get("highlightedIndex"), 0)
  autocompleteField.send("moveHighlightUp")
  equal(autocompleteField.get("highlightedIndex"), -1)
  autocompleteField.send("moveHighlightUp")
  equal(autocompleteField.get("highlightedIndex"), -1)


test "hide setsSuggestions isAutocompleting to false and returns highlighed index to -1", ->
  autocompleteField = @subject(
    isAutocompleting: true,
    highlightedIndex: 0
  )

  autocompleteField.send("hideSuggestions")
  ok(!autocompleteField.get("isAutocompleting"))
  equal(autocompleteField.get("highlightedIndex"), -1)


test "modifying value resets highlight index", ->
  autocompleteField = @subject(
    suggestions: suggestions,
    value: "S",
    queryProperty: "name"
  )

  equal(autocompleteField.get("highlightedIndex"), -1)
  autocompleteField.send("moveHighlightDown")
  equal(autocompleteField.get("highlightedIndex"), 0)
  autocompleteField.set("value", "pr")
  equal(autocompleteField.get("highlightedIndex"), -1)


test "modifying value reshows hidden suggestions", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "S",
    queryProperty: "name"
  )

  autocompleteField.send("hide")
  ok(!autocompleteField.get("isAutocompleting"))
  autocompleteField.set("value", "pr")
  ok(autocompleteField.get("isAutocompleting"))


test "highlightSuggestion highlights suggestion", ->
  autocompleteField = @subject(
    suggestions: suggestions,
    value: "Pr",
    queryProperty: "name"
  )

  autocompleteField.send("highlightSuggestion", pringles)
  equal(autocompleteField.get("highlightedIndex"), 0)
  ok(pringles.get("isHighlighted"))


test "selectSuggestion sets value to passed suggestion value", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "Pr",
    queryProperty: "name"
  )

  autocompleteField.send("selectSuggestion", pringles)
  equal(autocompleteField.get("value"), pringles.get("name"))

test "selectHighlightedSuggestion sets value to currently highlighted suggestion", ->
  autocompleteField = @subject(
    suggestions: suggestions
    value: "Pr",
    queryProperty: "name"
    highlightedIndex: 0
  )

  autocompleteField.send("selectHighlightedSuggestion")
  equal(autocompleteField.get("value"), pringles.get("name"))

test "selectSuggestion hides suggestions and calls onSelect callback", ->
  expect(2)

  targetObject = selectCallback: -> ok(true, "action was triggered!")
  autocompleteField = @subject(
    suggestions: suggestions
    value: "Pr",
    queryProperty: "name"
    targetObject: targetObject
    onSelect: "selectCallback"
  )

  autocompleteField.send("selectSuggestion", pringles)
  equal(autocompleteField.get("isAutocompleting"), false,
    "selectSuggestions should set isAutocompleting to false")

test "selectSuggestion calls callback with null when default selection is selected", ->
  expect(1)

  targetObject = selectCallback: (argument)->
    equal(argument, null, "Expected null argument passed to selection callback")

  autocompleteField = @subject(
    suggestions: suggestions
    value: "blahlblahblah",
    queryProperty: "name"
    targetObject: targetObject
    onSelect: "selectCallback"
    highlightedIndex: 0
    pinnedSuggestion: "something"
  )

  autocompleteField.send("selectHighlightedSuggestion")