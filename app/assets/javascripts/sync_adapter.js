var forEach = Ember.EnumerableUtils.forEach;

App.SyncAdapter = DS.ActiveModelAdapter.extend({
  namespace: "api/v1",
  databaseName: "grezha",

  init: function() {
    localforage.config({
      name        : this.get('databaseName'),
      version     : 1.0,
      storeName   : 'sync',
      description : 'locally cached data for Grezha'
    });

    return this._super();
  },

  findAll: function(store, type, sinceToken) {
    var promise = this._super(store, type, sinceToken),
        self = this;

    return Promise.cast(promise, "SyncAdapter: making localforage calls")
      .then(function(payload) {
        return new Promise(function(resolve, reject) {
          localforage.setItem(
            type.typeKey,
            Ember.copy(payload, true),
            resolve(payload)
          );
        });

      }).catch(function(error) {
        App.set('online', false);

        return new Promise(function(resolve, reject) {
          localforage.getItem(type.typeKey, function(value) {
            if(value) resolve(value);
            else      reject("No locally cached data");
          });
        });
      });
  },
});

App.ApplicationAdapter = App.SyncAdapter;