`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module "Events page integration test",
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)

test "Navigation link takes you to the Events page", ->
  visit("/")
  click("#events-link")
  andThen ->
    equal(currentURL(), "/events",
      "Events tab directs to events page")

test "Add event from events page", ->
  visit("/events")
  click("#add-event")
  andThen ->
    equal(currentURL(), "/events/new",
      "Add event button directs to new event form")


test "Date defaults to start of the current hour", ->
  @app.register("datetime:test", Ember.Object.create({
    now: -> new Date(1, 1, 2017, 14)
  }), { instantiate: false })
  @app.inject("route", "datetime", "datetime:test")

  visit("/events/new")

  andThen ->
    equal(find(".selected-hours").val(), "02")
    equal(find(".selected-minutes").val(), "00")
    equal(find(".selected-am-pm").val(), "pm")