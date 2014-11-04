App.ContactEditRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor('contact')

  setupController: (controller,model) ->
    controller.set('allUsers', @store.find('user'))
    @_super(controller, model)

  deactivate: ->
    @currentModel.rollback()
