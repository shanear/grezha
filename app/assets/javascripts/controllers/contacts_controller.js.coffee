App.ContactsController = Ember.ArrayController.extend
  filterQuery: ""

  filteredContacts: (->
    this.filter (contact)=>
      ~contact.get('name').toUpperCase().indexOf this.filterQuery.toUpperCase()
  ).property('@each.name', 'filterQuery')