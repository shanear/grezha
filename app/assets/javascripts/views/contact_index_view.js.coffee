App.ContactIndexView = Ember.View.extend
  didInsertElement: ->
    # If image url is out of date, reload the model
    @$("img").error =>
      @get('controller.model').reload()

  templateName: 'contact/index'