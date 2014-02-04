App.ContactsController = Ember.ArrayController.extend
  filterQuery: ""

  filteredContacts: (->
    this.filter (contact)=>
      ~contact.get('name').indexOf this.filterQuery
  ).property('@each.name', 'filterQuery')