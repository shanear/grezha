App.ContactsNewRoute = Ember.Route.extend
  model: (params)->
    @set('name', params.name)