App.RelationshipEditRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor('relationship')