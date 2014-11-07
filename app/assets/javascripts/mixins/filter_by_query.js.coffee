App.FilterByQuery = Ember.Mixin.create
  filterQuery: ""

  isMatched: (expected, actual) ->
    expected && ~expected.toUpperCase().indexOf actual.toUpperCase()

  filteredCollection: (->
    @filter (model)=>
      @get('filterBy').some (elem)=>
        @isMatched model.get(elem), @filterQuery
  ).property('@each.name', 'filterQuery')

  newModelText: (->
    if @get('filterQuery').length < 2
      @get('modelName')
    else
      @get('filterQuery')
  ).property('filterQuery')
