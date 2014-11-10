App.Person = DS.Model.extend
  name: DS.attr('string')
  contactInfo: DS.attr('string')
  role: DS.attr('string')
  notes: DS.attr('string')
