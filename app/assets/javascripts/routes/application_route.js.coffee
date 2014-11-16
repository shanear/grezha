App.ApplicationRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set('allContacts', @store.find('contact'))
