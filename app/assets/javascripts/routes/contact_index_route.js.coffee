App.ContactIndexRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor("contact")

  setupController: (controller,model) ->
    controller.set('allPeople', @store.find('person'))
    @_super(controller, model)
