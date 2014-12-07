App.ContactsController = Ember.ArrayController.extend App.FilterByQuery,
  filterBy: ["name", "user.name"]
  modelName: "Client"