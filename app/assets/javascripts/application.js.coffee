# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery-fileupload/basic
#= require ./image_assets
#= require handlebars
#= require ember
#= require ember-data
#= require_tree ../../../vendor/assets/javascripts/.
#= require moment
#= require_self
#= require localforage
#= require jquery.cookie

#= require ember_app
#= require sync_adapter
#= require_tree ./mixins
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require_tree ./routes
#= require ./router

# This fixes an issue where localforage breaks because Promise isn't defined.
# The issue only happens when the assets were minified on Safari. Probably worth
# revisiting at some point.
window.Promise = Ember.RSVP.Promise