App.ContactsNewRoute = App.BaseRoute.extend
  model: (params)->
    { name: params.name }
