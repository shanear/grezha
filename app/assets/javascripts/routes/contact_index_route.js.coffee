App.ContactIndexRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor("contact")

  setupController: (controller,model) ->
    controller.set('relationships', @store.find('relationship'))
    @_super(controller, model)
