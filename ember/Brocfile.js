/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

// Add offline manifest in production
if (app.env === 'production') {
  app.options.inlineContent = {
    'manifest' : {
      content: 'manifest="manifest.appcache"'
    }
  }
}

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

app.import('bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js');

// Fontello
app.import('vendor/fontello/css/animation.css');
app.import('vendor/fontello/css/grezha-icons.css');
app.import('vendor/fontello/font/grezha-icons.ttf', {
  destDir: 'font'
});
app.import('vendor/fontello/font/grezha-icons.eot', {
  destDir: 'font'
});
app.import('vendor/fontello/font/grezha-icons.svg', {
  destDir: 'font'
});
app.import('vendor/fontello/font/grezha-icons.woff', {
  destDir: 'font'
});

app.import('bower_components/moment/moment.js');
app.import('bower_components/localforage/dist/localforage.js')

if (app.env === 'test') {
  app.import('bower_components/timekeeper/lib/timekeeper.js');
}

module.exports = app.toTree();
