var forEach = Ember.EnumerableUtils.forEach,
    Promise = Ember.RSVP.Promise,
    inflector = Ember.Inflector.inflector;



App.SyncAdapter = DS.ActiveModelAdapter.extend({
  namespace: "api/v1",
  databaseName: "grezha",
  featuresEnabled: "safe",

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

    return Promise.cast(promise, "SyncAdapter: saving API data locally for " + type.typeKey)
      .then(function(payload) {
        return self._cacheRecords(payload, type);

      }).catch(function(error) {
        App.set('online', false);

        return new Promise(function(resolve, reject) {
          localforage.getItem(type.typeKey, function(records) {
            if(records) resolve(records);
            else        reject("No locally cached data");
          });
        });
      });
  },

  createRecord: function(store, type, record) {
    var promise = this._super(store, type, record),
        self = this;

    if(this.get('featuresEnabled') === "edge") {
      return Promise.cast(promise, "SyncAdapter: saving record " + type.typeKey)
        .then(function(payload) {
          return self._addRecordLocal(store, type, payload, true);
        }).catch(function(error) {
          return self._addRecordLocal(store, type, record, false);
        });
    }
    else {
      return promise;
    }
  },

  // Combine remotely fetched records with unsynced local records and cache them
  _cacheRecords: function(records, type) {
    var self = this;

    return new Promise(function(resolve, reject) {
        localforage.getItem(type.typeKey, function(cachedRecords) {
          var recordsKey = inflector.pluralize(type.typeKey);

          if(cachedRecords) {
            var recordsToAdd = cachedRecords[recordsKey].filter(function(record) {
              return (record["isSynced"] === false);
            });

            records[recordsKey] = records[recordsKey].concat(recordsToAdd);
          }

          localforage.setItem(
            type.typeKey,
            Ember.copy(records, true),
            resolve(records)
          );
        })
      });
  },

  _addRecordLocal: function(store, type, record, synced) {
    var serializer = store.serializerFor(type.typeKey);

    return new Promise(function(resolve, reject) {
      localforage.getItem(type.typeKey, function(records) {
        if(!records) reject("No locally cached data for type " + type.typeKey);

        var data = {},
            recordData = {},
            recordsKey = inflector.pluralize(type.typeKey);

        // If the record is synced, it will be in JSON format
        // If its only saved locally, it will be a Ember object
        // TODO: make this a little more robust and check data types
        //       its possible that the synced arg isn't needed
        if(!synced) {
          serializer.serializeIntoHash(data, type, record, { includeId: true });

          recordData = data[type.typeKey];
          // TODO: this should be added before the save comes back
          // TODO: this should be some sort of UUID
          recordData["id"] = 123;
          recordData["isSynced"] = false;
        }
        else {
          data = record;
          recordData = data[type.typeKey];
        }

        records[recordsKey].push(recordData);
        localforage.setItem(type.typeKey, records, resolve(data));
      });
    });
  },
});

App.ApplicationAdapter = App.SyncAdapter;