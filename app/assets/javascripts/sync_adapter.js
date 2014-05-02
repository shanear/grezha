var forEach = Ember.EnumerableUtils.forEach;

App.SyncAdapter = DS.ActiveModelAdapter.extend({
  namespace: "api/v1",

  init: function() {
    localforage.config({
      name        : 'grezha',
      version     : 1.0,
      storeName   : 'sync',
      description : 'locally cached data for Grezha'
    });

    return this._super();
  },

  findAll: function(store, type, sinceToken) {
    var promise = this._super(store, type, sinceToken),
        self = this;

    return promise.then(function(payload) {
      self._localSync(type, payload);
      return payload;
    }).catch(function(error) {
      // Don't returned cached data for now.
      // return localforage.getItem(type.typeKey);
    });
  },

  _localSync: function(type, payload) {
    localforage.setItem(type.typeKey, Ember.copy(payload, true));
  }
});

App.ApplicationAdapter = App.SyncAdapter;