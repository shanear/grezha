App.PersonEditRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor('person')