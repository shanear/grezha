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

  // Go through each of the changes and apply them to the server.
  // When completed successfully, associated records are marked as
  // unsynced.
  // Changes are executed syncronously so that they don't error
  // if they are temporaly depenedent.
  // TODO: When a change is unsuccessful, what should happen?
  syncRecords: function() {
    var self = this;

    return new Promise(function(resolve, reject) {
      localforage.getItem("changes", function(changes) {
        if(!changes) return resolve();

        var lastChange = Promise.resolve(true);
        changes.forEach(function(change) {
          lastChange = lastChange.then(function() {
            return self._commitChange(change);
          });
        });

        lastChange.then(function() {
          localforage.setItem("changes", [], resolve);
        });
      });
    });
  },

  findAll: function(store, type, sinceToken) {
    var promise = this._super(store, type, sinceToken),
        self = this;

    return Promise.cast(promise, "SyncAdapter: saving API data locally for " + type.typeKey)
      .then(function(payload) {
        return self._cacheRecords(payload, type);

      }).catch(function(error) {
        // TODO: going offline isn't the only reason this could fail.
        //       need to assess the possibilities
        App.set('online', false);

        return new Promise(function(resolve, reject) {
          localforage.getItem(type.typeKey, function(records) {
            if(records) resolve(records);
            else        reject("No locally cached data");
          });
        });
      });
  },

  findMany: function(store, type, ids) {
    if(this.get('featuresEnabled') === "edge") {
      // Shortcut findMany to findAll for now for caching purposes
      return this.findAll(store, type);
    }
    else {
      return this._super(store, type, ids);
    }
  },

  createRecord: function(store, type, record) {
    var promise = this._super(store, type, record),
        self = this;

    if(this.get('featuresEnabled') === "edge") {
      return Promise.cast(promise, "SyncAdapter: saving record " + type.typeKey)
        .then(function(payload) {
          return self._cacheRecord(type, payload);
        }).catch(function(error) {
          return self._addLocalRecord(store, type, record);
        });
    }
    else {
      return promise;
    }
  },

  generateIdForRecord: function() {
    var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    return "xxxxxxxx".replace(/x/g, function() {
      return chars[Math.round(Math.random() * (chars.length - 1))];
    });
  },

  // Combine remotely fetched records with unsynced local records and cache them
  _cacheRecords: function(records, type) {
    var self = this;

    return new Promise(function(resolve, reject) {
      localforage.getItem(type.typeKey, function(cachedRecords) {
        var recordsKey = inflector.pluralize(type.typeKey);

        if(cachedRecords) {
          var recordsToAdd = cachedRecords[recordsKey].filter(function(record) {
            return ((record["unsynced_changes"] || 0) > 0);
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

  // Whenever a change is made offline, record it in the "changes" table.
  // This way the changes can easily be applied to the server when
  // returning back online.
  _addLocalChange: function(recordType, recordId, action, payload) {
    return new Promise(function(resolve, reject) {
      localforage.getItem("changes", function(changes) {
        if(!changes) changes = [];

        changes.push({
          action: action,
          record_type: recordType,
          record_id: recordId,
          payload: payload
        });

        localforage.setItem("changes", changes, resolve);
      });
    });
  },

  // Caches a record retrieved from the server
  _cacheRecord: function(type, payload) {
    return this._saveLocalRecord(type.typeKey, payload[type.typeKey])
      .then(function() { return payload; });
  },

  // Adds a record only stored offline
  _addLocalRecord: function(store, type, record) {
    var self = this,
        data = {},
        serializer = store.serializerFor(type.typeKey),
        recordsKey = inflector.pluralize(type.typeKey);

    serializer.serializeIntoHash(data, type, record, { includeId: true });

    var recordData = data[type.typeKey];
    recordData["unsynced_changes"] = 1;

    return this._saveLocalRecord(type.typeKey, recordData).then(function() {
      return self._addLocalChange(type.typeKey, recordData['id'], 'create', data)
        .then(function() { return data; });
    });
  },

  // Fetches the record data hash from localforage for a certain type and id
  _fetchLocalRecord: function(recordType, recordId) {
    return new Promise(function(resolve, reject) {
      localforage.getItem(recordType, function(records) {
        if(!records) reject("There are no locally stored records for this type");

        var recordsKey = inflector.pluralize(recordType);

        records[recordsKey] = records[recordsKey] || []
        var recordsWithId = records[recordsKey].filter(function(record) {
            return record["id"] == recordId;
          });

        if(!recordsWithId.length == 1) reject("There is no record with this id");
        resolve(recordsWithId[0]);
      })
    });
  },

  // Saves record data into local storage using the 'recordData' hash
  _saveLocalRecord: function(recordType, recordData) {
    return new Promise(function(resolve, reject) {
      localforage.getItem(recordType, function(records) {
        var recordsKey = inflector.pluralize(recordType),
            recordId = recordData['id'];

        records = records || { }

        // Remove the record with the matching id
        records[recordsKey] = records[recordsKey] || []
        records[recordsKey] = records[recordsKey].filter(function(record) {
            return record["id"] != recordId;
          })
        records[recordsKey].push(recordData);

        localforage.setItem(recordType, records, resolve);
      });
    });
  },

  // Commits a change to server
  // Returns a promise that resovles when the change completed
  _commitChange: function(change) {
    var self = this;
        payload = change['payload'],
        action = change['action'],
        recordId = change['record_id'],
        recordType = change['record_type'];

    if(!(payload && action && recordId && recordType)) {
      return Promise.reject("Change was missing required attributes");
    }

    commitChange = this.ajax(this.buildURL(recordType), "POST", { data: payload });

    return commitChange.then(function(response) {
      return self._resolveChange(recordType, recordId);
    });
  },

  // Decrements the number of unsynced changes recorded for a record
  _resolveChange: function(recordType, recordId) {
    var self = this;

    return this._fetchLocalRecord(recordType, recordId).then(function(recordData) {
      if(recordData["unsynced_changes"] && recordData["unsynced_changes"] > 0)
        recordData["unsynced_changes"] -= 1;

      return self._saveLocalRecord(recordType, recordData);
    });
  }
});

DS.Store.reopen({
  syncRecords: function() {
    var adapter = this.get('defaultAdapter');
    if(adapter && adapter.syncRecords) {
      return this.get('defaultAdapter').syncRecords();
    }
  }
});

App.Store = DS.Store.extend({ adapter: App.SyncAdapter });