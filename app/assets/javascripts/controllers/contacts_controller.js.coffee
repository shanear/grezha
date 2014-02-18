App.ContactsController = Ember.ArrayController.extend
  filterQuery: ""
  newContactText: "Contact"

  filteredContacts: (->
    this.filter (contact)=>
      ~contact.get('name').toUpperCase().indexOf this.filterQuery.toUpperCase()
  ).property('@each.name', 'filterQuery')

  filterQueryObserver: (->
    if @get('filterQuery').length == 0
      @set('newContactText', 'Contact')
    else
      @set('newContactText', @get('filterQuery'))
  ).observes('filterQuery')