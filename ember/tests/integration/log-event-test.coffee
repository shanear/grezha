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
  @api.set('participations', [{id: 7, event_id: 1, contact_id: 4, registered_at: moment()}])

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
    equal(savedEvent.log_notes, "my brain is exploding",
      "logged event should save log notes")
    equal(savedEvent.other_attendee_count, "123",
      "logged event should save other attendee count")
    equal(currentURL(), "/events/1",
      "transitions to event page after logging finished")


test "'Everybody attended' button selects all registered attendees", ->
  @api.set('events', [
    { id: 1, name: "the big show", startsAt: moment().subtract(1, 'hours') }
  ]);
  @api.set('contacts', [{id: 4, name: "Bill Murray"}, {id: 5, name: "Steve Buscemi"}])
  @api.set('participations', [
    {id: 7, event_id: 1, contact_id: 4, registered_at: moment()},
    {id: 8, event_id: 1, contact_id: 5, registered_at: moment()}
  ])

  visit("events/1/log")
  click("#everybody-attended")

  andThen ->
    equal(find(".confirm-registration.is-confirmed").length, 2,
      "registrations should all be confirmed when clicking everybody")
    ok(!exists("#everybody-attended"),
      "Everybody button disappears when everybody is marked as attended")


test "Registered attendees is hidden when no registrations", ->
  @api.set('events', [
    { id: 1, name: "the not so big show", startsAt: moment().subtract(1, 'hours') }
  ]);

  visit("events/1/log")
  andThen =>
    ok(!exists("h4.registered-attendees"), "should hide registrations heading")
    ok(!exists(".registration-list"), "should hide registration list")
    ok(!exists("h4.other-attendees"), "should hide other attendees heading")


test "Adding and saving additional attendees", ->
  @api.set('events', [
    { id: 1, name: "the big show", startsAt: moment().subtract(1, 'hours') }
  ]);
  @api.set('contacts', [{id: 4, name: "Bill Murray"}])

  visit("events/1/log")
  fillIn("#add-participant", "Bil")
  click(".suggestions.active a")
  andThen ->
    equal(find(".added-attendee").length, 1,
      "Adding a new attendee should add it to the list")

  click("#save-log")
  andThen =>
    savedParticipation = @api.get('savedParticipation')
    equal(savedParticipation.event_id, 1, "should save new participation event_id")
    equal(savedParticipation.contact_id, 4, "should save new participation contact_id")
    ok(savedParticipation.confirmed_at, "should set confirmed date of new attendees")


test "Removing unregistered attendees", ->
  @api.set('events', [
    { id: 1, name: "the big show", startsAt: moment().subtract(1, 'hours') }
  ]);
  @api.set('contacts', [{id: 4, name: "Bill Murray"}])

  visit("events/1/log")
  fillIn("#add-participant", "Bil")
  click(".suggestions.active a")
  click(".added-attendee")
  andThen ->
    equal(find(".added-attendee").length, 0,
      "Clicking an added attendee should remove it from the list")


test "Updating event log unconfirms registered participations", ->
  ok("Change me")
  @api.set('events', [{
    id: 1,
    name: "pool time",
    starts_at: moment().subtract(1, 'hours'),
    logged_at: moment(),
  }]);
  @api.set('contacts', [{id: 4, name: "Hope Solo"}])
  @api.set('participations', [{id: 7, event_id: 1, contact_id: 4, confirmed_at: moment(), registered_at: moment()}])

  visit("/events/1/log")
  andThen ->
    ok(exists(".confirm-registration.is-confirmed"),
      "Should show confirmed registration when modifying logged event")
    ok(!exists(".added-attendee"),
      "Shouldn't show added attendee when none exist")

  click(".confirm-registration")
  click("#save-log")
  andThen =>
    ok(@api.get('savedParticipation'),
      "unconfirming a confirmed registration should update it")
    ok(!@api.get('savedParticipation').confirmed_at,
      "unconfirming a confirmed registration should set confirmed at to null")


test "Updating event log removes added participations", ->
  @api.set('events', [{
    id: 1,
    name: "pool time",
    starts_at: moment().subtract(1, 'hours'),
    logged_at: moment(),
  }]);
  @api.set('contacts', [{id: 4, name: "Hope Solo"}])
  @api.set('participations', [{id: 22, event_id: 1, contact_id: 4, confirmed_at: moment()}])

  visit("/events/1/log")
  andThen ->
    ok(!exists(".confirm-registration.is-confirmed"),
      "Shouldn't show registrations when none exist")
    ok(exists(".added-attendee"),
      "Should show added attendees when modifying logged event")

  click(".added-attendee")

  andThen ->
    ok(!exists(".added-attendee"),
      "Should remove added attendees after marking them for removal")

  click("#save-log")
  andThen =>
    equal(@api.get('deletedParticipationId'), 22,
      "removing an added participation should delete it")
