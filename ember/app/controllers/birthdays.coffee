`import Ember from 'ember'`

BirthdaysController = Ember.ObjectController.extend
  contacts: Ember.computed.alias('model')
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

`export default BirthdaysController`