App.ContactEditRoute = App.BaseRoute.extend
  model: (params)->
    @modelFor('contact')

  deactivate: ->
    @currentModel.rollback()
