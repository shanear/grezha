import Ember from 'ember';
import Application from '../../app';
import Router from '../../router';
import config from '../../config/environment';
import 'simple-auth-testing/test-helpers';
import './contains';
import './exists';

export default function startApp(attrs) {
  var application;

  var attributes = Ember.merge({}, config.APP);
  attributes = Ember.merge(attributes, attrs); // use defaults, but you can override;

  Ember.run(function() {
    application = Application.create(attributes);
    application.setupForTesting();
    application.injectTestHelpers();

    if (localforage.pendingTransactions === undefined) {
      localforage.pendingTransactions = 0;
    }

    Ember.Test.registerWaiter(function() {
      return localforage.pendingTransactions === 0;
    });
  });

  return application;
}
