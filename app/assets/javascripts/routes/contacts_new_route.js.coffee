App.ContactsNewRoute = App.BaseRoute.extend
  model: (params)->
    {
      name: params.name
      addedAt: new Date()
    }

  setupController: (controller,model) ->
    controller.set('allUsers', @store.find('user'))
    @_super(controller, model)
