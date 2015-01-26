`import Ember from 'ember'`

SearchResultComponent = Ember.Component.extend
  find_by_substring: (haystack, needle) ->
    haystack && ~haystack.toUpperCase().indexOf needle.toUpperCase()

  name: (->
    needle = @get('filterQuery')
    haystack = @get('filterItem').get('name')
    new Ember.Handlebars.SafeString @highlightedText haystack, needle
  ).property('filterQuery')

  searchMatch: (->
    criterias = @get('filterItem').get('highlightFields')
    if criterias.length > 0 && @get('filterQuery') != ""
      needle = @get('filterQuery')
      haystack = @get('filterItem').get(criterias.get(0))
      new Ember.Handlebars.SafeString @highlightedText haystack, needle
    else
      null
  ).property('filterQuery')

  highlightedText: (haystack, needle)->
    if needle isnt ""
      ignoreCaseRegex = new RegExp(needle,'i')
      haystack.replace(ignoreCaseRegex, "<span class='highlight'>$&</span>")
    else
      haystack

`export default SearchResultComponent`