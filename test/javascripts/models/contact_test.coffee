moduleForModel 'contact', 'Contact Model',
  {needs: ['model:connection']}


test 'isValid', ->
  contact = @subject(name: "Leeroy McDinkins")
  ok(contact.isValid())

  Ember.run -> contact.set("name", "")
  equal(contact.isValid(), false)


test 'isDuplicate', ->
  contact = @subject(name: "Samantha Stoops")
  equal(contact.isDuplicate(), false)

  Ember.run ->
    contact.get("store").createRecord('contact', {name: "Fran"})
    contact.set("name", "Fran")

  ok(contact.isDuplicate())
