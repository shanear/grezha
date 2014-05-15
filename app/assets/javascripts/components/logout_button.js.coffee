App.LogoutButtonComponent = Ember.Component.extend
  tagName: 'a'
  attributeBindings: ['linkTo:href']
  ariaRole: 'link'
  layout: Ember.Handlebars.compile('Logout')

  linkTo: (->
    if @get('online') then '/logout' else null
  ).property('online')

  onlineBinding: Ember.Binding.oneWay('App.online')

  click: ->
    #return true if @get('online')
    $.removeCookie 'remember_token'
    localforage.clear()
    App.set('loggedIn', false)
    @get('targetObject').transitionToRoute('logout')
