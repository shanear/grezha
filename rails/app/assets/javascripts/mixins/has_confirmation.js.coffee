App.HasConfirmation = Ember.Mixin.create
  confirmation: Ember.computed -> { show: false }

  reset: ->
    @set('confirmation', { show: false })


  actions:
    confirmationAction: ->
      @get('confirmation').action()
      @set("confirmation", { show: false })

    cancelConfirmation: ->
      @set("confirmation", { show: false })
