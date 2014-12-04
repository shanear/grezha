# Teaspoon includes some support files, but you can use anything from your own support path too.
# require support/sinon
# require support/your-support-file
#
# PhantomJS (Teaspoons default driver) doesn't have support for Function.prototype.bind, which has caused confusion.
# Use this polyfill to avoid the confusion.
#= require support/bind-poly
#
# Deferring execution
# If you're using CommonJS, RequireJS or some other asynchronous library you can defer execution. Call
# Teaspoon.execute() after everything has been loaded. Simple example of a timeout:
#
# Teaspoon.defer = true
# setTimeout(Teaspoon.execute, 1000)
#
# Matching files
# By default Teaspoon will look for files that match _test.{js,js.coffee,.coffee}. Add a filename_test.js file in your
# test path and it'll be included in the default suite automatically. If you want to customize suites, check out the
# configuration in config/initializers/teaspoon.rb
#
# Manifest
# If you'd rather require your test files manually (to control order for instance) you can disable the suite matcher in
# the configuration and use this file as a manifest.
#
# For more information: http://github.com/modeset/teaspoon
#
# You can require your own javascript files here. By default this will include everything in application, however you
# may get better load performance if you require the specific files that are being used in the test that tests them.
#= require support/setup

# TODO: We pre-include localforage to deal with the Safari bug, remove this when its fixed
#= require localforage

#= require application
#= require ember-qunit/dist/globals/main
#= require FakeXMLHttpRequest
#= require route-recognizer
#= require pretender
#= require support/ember_setup
(->
  module = ""
  test = ""
  lastModuleLogged = ""
  lastTestLogged = ""
  failuresOnCurrentTest = 0
  failureFound = false
  QUnit.moduleStart (details) ->
    module = details.name
    return

  QUnit.testStart (details) ->
    test = details.name
    return

  QUnit.log (details) ->
    unless details.result
      unless failureFound
        failureFound = true
        console.log "/n"
        console.log "/*********************************************************************/"
        console.log "/************************** FAILURE SUMMARY **************************/"
        console.log "/*********************************************************************/"
      unless lastModuleLogged is module
        console.log ""
        console.log "-----------------------------------------------------------------------"
        console.log "Module: " + module
      unless lastTestLogged is test
        failuresOnCurrentTest = 1
        console.log "-----------------------------------------------------------------------"
        console.log "Test: " + test
      else
        failuresOnCurrentTest++
      console.log " " + failuresOnCurrentTest + ") Message: " + details.message
      if typeof details.expected isnt "undefined"
        console.log "    Expected: " + details.expected
        console.log "    Actual: " + details.actual
      console.log "    Source: " + details.source  if typeof details.source isnt "undefined"
      lastModuleLogged = module
      lastTestLogged = test
    return

  QUnit.done (details) ->
    if details.failed > 0
      console.log "-----------------------------------------------------------------------"
      console.log ""
    return

  return
)()