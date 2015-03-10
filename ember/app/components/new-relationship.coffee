`import Ember from 'ember'`

NewRelationshipComponent = Ember.Component.extend
  enabled: false
  autofocusRole: true
  name: Ember.computed.alias("newPerson.name")
  role: Ember.computed.alias("newPerson.role")
  contactInfo: Ember.computed.alias("newPerson.contactInfo")
  notes: Ember.computed.alias("newPerson.notes")
  isSaving: false

  _reset: (->
    if !@get('enabled')
      @set("newPerson", null)
      @set("errors", null)
      @set("isSaving", false)
      @set("newRelationshipName", "")
  ).observes('enabled')

  createRelationship: (person) ->
    newRelationship = @store.createRecord('relationship', {
        person: person
        contact: @get('contact')
      })

    newRelationship.save().then =>
      @get('contact.relationships').unshiftObject newRelationship
      @set('enabled', false)

  actions:
    selectPerson: (person) ->
      if person?
        @set("newPerson", null)
        @createRelationship(person)
      else
        @set("newPerson", {name: @get("newRelationshipName")})

    savePerson: ->
      newPerson = @store.createRecord('person', @get("newPerson"))

      if newPerson.isValid()
        @set("isSaving", true)
        newPerson.save().then (=>
          @createRelationship(newPerson)
          @set("isSaving", false)
        ), (=>
          @set("isSaving", false)
          @set('errors', ["There was a technical error. Please try again, or contact Grezha support."])
        )
      else
        @set('errors', newPerson.get('errors'))

    cancel: ->
      @set('enabled', false)


`export default NewRelationshipComponent`