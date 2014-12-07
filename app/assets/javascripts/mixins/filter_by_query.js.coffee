App.FilterByQuery = Ember.Mixin.create
  filterQuery: ""
  find_by_substring: (haystack, needle) ->
    haystack && ~haystack.toUpperCase().indexOf needle.toUpperCase()

  filteredCollection: (->
    @filter (model)=>
      matches = []
      for criteria in @get('filterBy')
        if @find_by_substring model.get(criteria), @filterQuery
          matches.push criteria
      filteredMatches = matches.filter (elem) ->
        elem isnt "name"
      model.set('highlightFields', filteredMatches)
      matches.length > 0
  ).property('@each.name','@each.user.name', 'filterQuery')

  newModelText: (->
    if @get('filterQuery').length < 2
      @get('modelName')
    else
      @get('filterQuery')
  ).property('filterQuery')
