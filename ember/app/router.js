import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('login');
  this.route('forgot-password');
  this.route('reset-password', { path: "/reset-password/:token" });

  this.resource('authenticated', { path: "/" }, function() {
    this.resource('contacts', { path: "/:contact_role" }, function() {
      this.route('new');
      this.route('new', { path: "/new/:name" });
      this.resource('contact', { path: "/:contact_id" }, function() {
        this.route('edit');
        this.resource('people', function() {
          this.resource('person', {path: "/:person_id"}, function() {
            this.route('edit');
          });
        });
      });
    });

    this.resource('vehicles', function() {
      this.route('new');
      this.route('new', { path: "/new/:name" });
      this.resource('vehicle', { path: "/:vehicle_id" }, function() {
        this.route('edit');
      });
    });

    this.resource('events', function() {
      this.route('all', { path: '/' });
      this.route('index', { path: "/:program_slug/upcoming" });
      this.route('new');
      this.resource('event', { path: "/:event_id" }, function(){
        this.route('edit');
      });
    });

    this.resource('birthdays');
  });
});

export default Router;
