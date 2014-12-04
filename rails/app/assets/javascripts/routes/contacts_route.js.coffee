App.ContactsRoute = App.BaseRoute.extend
  model: ->
    @get('store').find('contact')