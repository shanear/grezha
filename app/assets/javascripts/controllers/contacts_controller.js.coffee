App.ContactsController = Ember.ArrayController.extend App.FilterByQuery,
  filterBy: ["name", "memberId"]
  modelName: "Contact"

