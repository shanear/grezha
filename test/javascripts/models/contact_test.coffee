moduleForModel 'contact', 'Contact Model',
  {needs: ['model:connection']}


test 'isValid', ->
  contact = @subject(name: "Leeroy McDinkins")
  ok(contact.isValid(), "Contact is valid by default")

  Ember.run -> contact.set("name", "")
  equal(contact.isValid(), false, "Contact isn't valid with empty name")


test 'isDuplicate', ->
  contact = @subject(name: "Samantha Stoops")
  equal(contact.isDuplicate(), false, "Contact isn't duplicate by default")

  Ember.run ->
    contact.get("store").createRecord('contact', {name: "Fran"})
    contact.set("name", "Fran")

  ok(contact.isDuplicate(), "Contact is duplicate when it has same name as another Contact")
