store = contact = relationship = null

moduleForModel 'relationship', 'Relationship Model',
  needs: ['model:contact', 'model:connection']
  setup: ->
    store = @store()
    Ember.run ->
      contact = store.createRecord('contact', name: "Ms McGrethory")
      relationship = store.createRecord('relationship',
        contact: contact,
        name: "Mr McGrethory",
        relationshipType: "husband")

test 'isValid', ->
  equal(relationship.isValid(), true, "Relationship is valid with valid attributes")

  Ember.run -> relationship.set("name", "")
  equal(relationship.isValid(), false, "Relationship isn't valid with empty name")

  Ember.run -> relationship.set("name", "    ")
  equal(relationship.isValid(), false, "Relationship isn't valid with whitespace name")

  Ember.run -> relationship.set("name", undefined)
  equal(relationship.isValid(), false, "Relationship isn't valid with undefined name")

  Ember.run -> relationship.set("name", "Shanze")
  Ember.run -> relationship.set("relationshipType", "")
  equal(relationship.isValid(), false, "Relationship Type isn't valid when empty")

  Ember.run -> relationship.set("relationshipType", "    ")
  equal(relationship.isValid(), false, "Relationship Type isn't valid when blank")

  Ember.run -> relationship.set("relationshipType", undefined)
  equal(relationship.isValid(), false, "Relationship Type isn't valid when undefined")
