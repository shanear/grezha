App.RelationshipEditController = Ember.ObjectController.extend
  errors: []
  test: "stuff"
  actions:
    saveRelationship: ->
      relationship = @get('model')
      if relationship.isValid()
        relationship.save().then(
          (relationship)=>
            @transitionToRoute('contact', relationship.get('contact'))
          ,(error)=>
            @set('errors', ["Something went wrong on the server, please try again later."]))
      else
        @set('errors',relationship.get('errors'))