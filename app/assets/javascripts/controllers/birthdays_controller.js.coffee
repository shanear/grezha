App.BirthdaysController = Ember.ObjectController.extend
  needs: ['application']
  contacts: Ember.computed.alias('controllers.application.allContacts')
  birthdaysToShow: 5

  contactsWithoutBirthdays: (->
    @get("contacts").filter (contact)-> !contact.get("birthday")?
  ).property("contacts.@each.birthday")

  contactsWithBirthdays: (->
    @get("contacts").filter (contact)-> contact.get("birthday")?
  ).property("contacts.@each.birthday")

  contactsWithRecentBirthdays: (->
    Ember.ArrayProxy.createWithMixins(Ember.SortableMixin,
      content: @get('contactsWithBirthdays')
      sortProperties: ['daysUntilBirthday']
      sortAscending: false
    ).slice(0, @birthdaysToShow)
  ).property("contactsWithBirthdays")

  contactsWithUpcomingBirthdays: (->
    Ember.ArrayProxy.createWithMixins(Ember.SortableMixin,
      content: @get('contactsWithBirthdays')
      sortProperties: ['daysUntilBirthday']
      sortAscending: true
    ).slice(0, @birthdaysToShow)
  ).property("contactsWithBirthdays")

  displayRecentBirthdays: (->
    @get('contactsWithBirthdays.length') > @birthdaysToShow
  ).property("contactsWithBirthdays")