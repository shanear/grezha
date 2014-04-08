App.ContactIndexRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor("contact")