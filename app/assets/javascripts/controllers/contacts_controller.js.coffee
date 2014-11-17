App.ContactsController = Ember.ArrayController.extend App.FilterByQuery,
  filterBy: ["name", "memberId", "user.name"]
  modelName: "Client"
