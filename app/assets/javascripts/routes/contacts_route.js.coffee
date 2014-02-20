App.ContactsRoute = Ember.Route.extend
  beforeModel: ->
    $("#loader").show()

  afterModel: ->
    $("#loader").hide()

  model: ->
    @get('store').find('contact')