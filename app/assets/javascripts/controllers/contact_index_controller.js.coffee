App.ContactIndexController = Ember.ObjectController.extend
  actions:
    changeImage: (url)->
      @set('model.pictureUrl', url)
