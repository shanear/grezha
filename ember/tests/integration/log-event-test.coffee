`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module "Log event page integration test",
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "Clicking on an unlogged event in the past takes you to the log event page", ->
  @api.set('events', [
    { id: 1, name: "the big show", startsAt: moment().subtract(1, 'hours') }
  ]);

  visit("/events/all/past")
  click(".event a")
  andThen ->
    equal(currentURL(), "/events/1/log",
      "should navigate to log page instead of event page")


test "Confirming registered participatnts", ->
  @api.set('events', [
    { id: 1, name: "the big show", startsAt: moment().subtract(1, 'hours') }
  ]);
  @api.set('contacts', [{id: 4, name: "Bill Murray"}])
  @api.set('participations', [{id: 7, event_id: 1, contact_id: 4}])

  visit("events/1/log")
  andThen ->
    equal(find(".confirm-registration").length, 1,
      "should have 1 registration to confirm")
    equal(find(".confirm-registration.is-confirmed").length, 0,
      "registrations should be not confirmed by default")

  click(".confirm-registration")
  andThen ->
    equal(find(".confirm-registration.is-confirmed").length, 1,
      "clicking a registration confirms it")

  click("#save-log")
  andThen =>
    savedParticipation = @api.get('savedParticipation')
    ok(savedParticipation.confirmed_at, "should set confirmed date of registrations")


test "Saving log notes & other attendees", ->
  @api.set('events', [
    { id: 1, name: "the big show", startsAt: moment().subtract(1, 'hours') }
  ]);

  visit("events/1/log")
  fillIn("#log-notes", "my brain is exploding")
  fillIn("#other-attendee-count", 123)
  click("#save-log")
  andThen =>
    savedEvent = @api.get('savedEvent')
    console.log(savedEvent)
    equal(savedEvent.log_notes, "my brain is exploding",
      "logged event should save log notes")
    equal(savedEvent.other_attendee_count, "123",
      "logged event should save other attendee count")

###
test "Registered attendees is hidden when no registrations", ->

test "'Everybody attended' button is hidden when one registration", ->

test "'Everybody attended' button selects all registered attendees", ->

test "Adding and saving unregistered attendees", ->
###