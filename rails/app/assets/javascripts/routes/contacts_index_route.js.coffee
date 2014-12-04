App.ContactsIndexRoute = App.BaseRoute.extend
  setupController: (controller) ->
    controller.set('allConnections', @store.find('connection'))
    @_super(controller)