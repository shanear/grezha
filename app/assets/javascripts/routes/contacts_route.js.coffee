App.ContactsRoute = Ember.Route.extend
  model: ->
    this.get('store').find('contact')