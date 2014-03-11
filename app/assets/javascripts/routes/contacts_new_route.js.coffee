App.ContactsNewRoute = Ember.Route.extend
  model: (params)->
    { name: params.name }
