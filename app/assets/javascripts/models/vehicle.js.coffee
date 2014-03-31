App.Vehicle = DS.Model.extend
  licensePlate: DS.attr('string')
  usedBy: DS.attr('string')
  notes: DS.attr('string')