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


test "Save event from event create page", ->
  visit("/events/new")

  fillIn("#event-name","Micah's Birthday")
  fillIn(".selected-month","1")
  fillIn(".selected-day","19")
  fillIn(".selected-year","2015")
  fillIn(".selected-hours","07")
  fillIn(".selected-minutes","15")
  fillIn(".selected-am-pm","am")
  fillIn("#where","Houston, Texas")
  fillIn("#notes","The day that will be remembered by all but forgotten by one")

  click("#save-event")

  andThen =>
    newEvent = @api.get("savedEvent")
    equal(newEvent.name, "Micah's Birthday")
    ok(/2015-01-19T..:15/.test(newEvent.starts_at))
    equal(newEvent.location, "Houston, Texas")
    equal(newEvent.notes, "The day that will be remembered by all but forgotten by one")


test "Date defaults to start of the current hour", ->
  @app.register("datetime:test", Ember.Object.create({
    now: -> new Date(1, 1, 2017, 15)
  }), { instantiate: false })
  @app.inject("route", "datetime", "datetime:test")

  visit("/events/new")

  andThen ->
    equal(find(".selected-hours").val(), "03")
    equal(find(".selected-minutes").val(), "00")
    equal(find(".selected-am-pm").val(), "pm")