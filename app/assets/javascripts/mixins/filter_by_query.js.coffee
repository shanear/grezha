App.FilterByQuery = Ember.Mixin.create
  filterQuery: ""
  find_by_substring: (expected, actual) ->
    expected && ~expected.toUpperCase().indexOf actual.toUpperCase()

  filteredCollection: (->
    @filter (model)=>
      @get('filterBy').some (elem)=>
        @find_by_substring model.get(elem), @filterQuery
  ).property('@each.name','@each.memberId','@each.user.name', 'filterQuery')

  newModelText: (->
    if @get('filterQuery').length < 2
      @get('modelName')
    else
      @get('filterQuery')
  ).property('filterQuery')
