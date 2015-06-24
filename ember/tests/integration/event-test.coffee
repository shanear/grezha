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
  @api.set('events', [{ id: 1, name: "Fishin", registration_ids: [1, 2]}])
  @api.set('contacts', [
    {id: 4, name: "Henry Stinkins"},
    {id: 5, name: "Donny Dinkins"},
    {id: 6, name: "Stanley Stumpins"},
  ]);
  @api.set('registrations', [
    {id: 1, event_id: 1, contact_id: 4},
    {id:  2, event_id: 1, contact_id: 6}
  ])

  visit("/events/1")
  andThen =>
    ok(contains(".registration-list li", "Henry Stinkins"))
    ok(contains(".registration-list li:eq(1)", "Stanley Stumpins"))


test "Adds registration", ->
  @api.set('events', [{ id: 1, name: "Scooby Doo Mystery Meeting"}])
  @api.set('contacts', [{id: 4, name: "Shaggy"}])

  visit("/events/1")
  fillIn("#add-registration", "Shag")
  click(".suggestions.active a")
  andThen =>
    savedRegistration = @api.get('savedRegistration')
    equal(savedRegistration.event_id, 1)
    equal(savedRegistration.contact_id, 4)