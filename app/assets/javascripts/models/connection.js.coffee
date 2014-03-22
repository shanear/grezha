App.Connection = DS.Model.extend
  contact: DS.belongsTo('contact')
  note: DS.attr('string')
  occurredAt: DS.attr('date')
