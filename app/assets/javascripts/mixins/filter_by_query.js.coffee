App.FilterByQuery = Ember.Mixin.create
  filterQuery: ""

  filteredCollection: (->
    @filter (model)=>
      ~model.get(@get('filterBy')).toUpperCase().indexOf this.filterQuery.toUpperCase()
  ).property('@each.name', 'filterQuery')

  newModelText: (->
    if @get('filterQuery').length < 2
      @get('modelName')
    else
      @get('filterQuery')
  ).property('filterQuery')
