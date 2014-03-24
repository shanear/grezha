App.ContactEditRoute = Ember.Route.extend
  model: (params)->
    @modelFor('contact')

  deactivate: ->
    @currentModel.rollback()
    console.log(@currentModel.get('name'))