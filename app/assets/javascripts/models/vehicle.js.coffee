App.Vehicle = DS.Model.extend
  license_plate: DS.attr('string')
  used_by: DS.attr('string')
  notes: DS.attr('string')