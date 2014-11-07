App.ContactIndexRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor("contact")

  setupController: (controller,model) ->
    controller.set('allRelationships', @store.find('relationship'))
    @_super(controller, model)
