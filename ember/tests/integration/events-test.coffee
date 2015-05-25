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


test "Show events in time order with date", ->
  @api.set('events', [
    {
      id: 1,
      name: "after party",
      starts_at: moment('2015-Jan-29', 'YYYY-MMM-DD').startOf('day').add(22, 'hours'),
      location: null
    },
    {
      id: 2,
      name: "main event",
      starts_at: moment('2015-Jan-29', 'YYYY-MMM-DD').startOf('day').add(18, 'hours'),
      location: "Palace of Peter"
    }
  ]);

  visit("/events")
  andThen ->
    ok(contains(".event-date", "Jan 29"))
    ok(contains(".event:first .name", "main event"))
    ok(contains(".event:first .time", "6:00 pm"))
    ok(contains(".event:last  .name", "after party"))
    ok(contains(".event:last  .time", "10:00 pm"))
    ok(contains(".event:first .location", "at Palace of Peter"),"Location Not Showing")
    ok(!contains(".event:last", "at"), "Location Showing")


test "Add event from events page", ->
  visit("/events")
  click("#add-event")
  andThen ->
    equal(currentURL(), "/events/new",
      "Add event button directs to new event form")


test "Save event button is disabled when invalid", ->
  visit("/events/new")
  andThen =>
    ok(find("#save-event").is(":disabled"))


test "Save event button is disabled when new program is invalid", ->
  visit("/events/new")
  fillIn("#event-name", "You dont want to miss this")
  andThen ->
    newProgramOption = find("#select-program option:last").val()
    fillIn("#select-program", newProgramOption)

  andThen =>
    ok(find("#save-event").is(":disabled"))


test "Save event has list of programs to choose", ->
  @api.set('programs', [
    { id: 1, name: "Peter Dinklage's Movie Club" },
    { id: 2, name: "Shane's Nerd Club for Nerds" }
  ]);

  visit("/events/new")
  andThen =>
    ok(!find("#select-program").val())
    equal(find("#select-program option:eq(0)").text(), "None")
    equal(find("#select-program option:eq(1)").text(), "Peter Dinklage's Movie Club")
    equal(find("#select-program option:eq(2)").text(), "Shane's Nerd Club for Nerds")
    equal(find("#select-program option:eq(3)").text(), "Add a program")


test "Create new program when creating event", ->
  visit("/events/new")
  fillIn("#event-name", "Hand dancing")

  andThen -> equal(find("#program-name").length, 0,
    "Program name field only appears if new program is selected")

  andThen ->
    newProgramOption = find("#select-program option:last").val()
    fillIn("#select-program", newProgramOption)

  fillIn("#program-name", "Hand dancing choir")
  click("#save-event")

  andThen =>
    newProgram = @api.get("savedProgram")
    ok(newProgram, "creating event should create new program")
    equal(newProgram.name, "Hand dancing choir"
      "Program name should match the filled in value")
    equal(@api.get("savedEvent").program_id, newProgram.id,
      "Event should be part of newly created program")


test "Save event from event create page", ->
  @api.set('programs', [{ id: 1, name: "Great birthdays" }])
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
  fillIn("#select-program","1")

  click("#save-event")

  andThen =>
    newEvent = @api.get("savedEvent")
    equal(newEvent.name, "Micah's Birthday")
    ok(/2015-01-19T..:15/.test(newEvent.starts_at))
    equal(newEvent.location, "Houston, Texas")
    equal(newEvent.notes, "The day that will be remembered by all but forgotten by one")
    equal(newEvent.program_id, "1")


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