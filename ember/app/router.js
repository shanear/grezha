import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('login');
  this.route('forgot-password');
  this.route('reset-password', { path: "/reset-password/:token" });
  this.resource('contacts', function() { });
});

export default Router;
