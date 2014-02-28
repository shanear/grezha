App.Connection = DS.Model.extend
  contact: DS.belongsTo('contact')
  note: DS.attr('string')
  date: DS.attr('date')