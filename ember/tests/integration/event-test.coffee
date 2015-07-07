`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module "Event page integration test",
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)

test "Shows list of registrations", ->
  @api.set('events', [{
    id: 1, name: "Fishin", participation_ids: [1, 2], starts_at: moment().add(1, 'hours')
  }])
  @api.set('contacts', [
    {id: 4, name: "Henry Stinkins"},
    {id: 5, name: "Donny Dinkins"},
    {id: 6, name: "Stanley Stumpins"},
  ]);
  @api.set('participations', [
    {id: 1, event_id: 1, contact_id: 4},
    {id:  2, event_id: 1, contact_id: 6}
  ])

  visit("/events/1")
  andThen =>
    ok(contains(".registration-list li", "Henry Stinkins"))
    ok(contains(".registration-list li:eq(1)", "Stanley Stumpins"))


test "Adds registration", ->
  @api.set('events', [
    { id: 1, name: "Scooby Doo Mystery Meeting", starts_at: moment().add(1, 'hours') }
  ]);
  @api.set('contacts', [{id: 4, name: "Shaggy"}])

  visit("/events/1")
  fillIn("#add-registration", "Shag")
  click(".suggestions.active a")
  andThen =>
    savedParticipation = @api.get('savedParticipation')
    equal(savedParticipation.event_id, 1)
    equal(savedParticipation.contact_id, 4)


test "Doesn't add duplicate registrations", ->
  @api.set('events', [{ id: 1, name: "Scooby Doo Mystery Meeting", startsAt: moment().add(1, 'hours') }])
  @api.set('contacts', [{id: 4, name: "Shaggy"}])

  visit("/events/1")
  fillIn("#add-registration", "Shag")
  click(".suggestions.active a")

  fillIn("#add-registration", "Shag")
  click(".suggestions.active a")

  andThen =>
    equal(find(".registration-list li").length, 1)


test "Doesn't add registration if server errors on create", ->
  @api.set('events', [{ id: 1, name: "Scooby Doo Mystery Meeting", startsAt: moment().add(1, 'hours') }])
  @api.set('contacts', [{id: 4, name: "Shaggy"}])
  @api.get('errors')['participations.create'] = true

  visit("/events/1")
  fillIn("#add-registration", "Shag")
  click(".suggestions.active a")

  andThen =>
    equal(find(".registration-list li.no-registrations").length, 1)


test "Deletes a registration", ->
  @api.set('events', [{ id: 1, name: "Scooby Doo Mystery Meeting", startsAt: moment().add(1, 'hours') }])
  @api.set('contacts', [{id: 4, name: "Shaggy"}])
  @api.set('participations', [{id: 7, event_id: 1, contact_id: 4}])

  visit("/events/1")
  andThen =>
    equal(find('.registration-list .confirm-delete-registration').length, 0,
      "The confirm delete button shouldn't appear until delete is clicked")

  click(".registration-list .delete-registration")
  click(".registration-list .confirm-delete-registration")
  andThen =>
    equal(@api.get('deletedParticipationId'), 7,
      "Clicking confirm delete should send a delete participation request to the api")


test "Shows logged event fields", ->
  @api.set('events', [{
    id: 1,
    name: "pool time",
    starts_at: moment().subtract(1, 'hours'),
    logged_at: moment(),
    log_notes: "cigarettes, diving boards, melancholy.",
    other_attendee_count: 12
  }]);
  @api.set('contacts', [{id: 4, name: "Bill Murray"}])
  @api.set('participations', [{id: 7, event_id: 1, contact_id: 4, confirmed_at: moment()}])

  visit("/events/1")
  andThen =>
    ok(contains("#log-notes", "cigarettes, diving boards, melancholy."),
      "logged event page should contain log notes")
    ok(contains(".attendees li", "Bill Murray"),
      "logged event lists attendees")

    ok(contains(".attendees li:last", "12 other attendees"),
      "logged event lists number of other attendees")
    ok(contains("#total-attendee-count", "13"),
      "logged event lists number of total attendees")


test "Delete an event", ->
  @api.set('events', [{
    id: 1,
    name: "pool time",
    starts_at: moment().subtract(1, 'hours'),
  }]);

  visit("events/1")
  click("#delete-event")
  click("#confirmation .cancel")
  andThen =>
    ok(!@api.get('deletedEventId'), "clicking cancel shouldn't delete event")
    ok(!exists("#confirmation"), "clicking cancel should remove the confirmation")

  click("#delete-event")
  click("#confirmation .confirm")
  andThen =>
    equal(@api.get('deletedEventId'), 1,
     "clicking confirm should delete event")
