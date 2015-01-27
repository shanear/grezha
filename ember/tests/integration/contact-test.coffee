`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Contact page integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "shows correctly for contact with no data", ->
  @api.set('contacts', [{id: 1, name: "Jane Doe"}])
  visit("/clients/1")
  andThen =>
    ok(contains("#contact-name", "Jane Doe"))
    ok(contains("#contact-birthday", "unknown"))
    ok(contains("#contact-user", "unassigned"))
    ok(contains("#contact-from", "unknown"))


test "shows correctly formatted information for contact", ->
  @api.set('users', [{id: 1, name: "Kat"}])
  @api.set('contacts', [{
    id: 1,
    name: "Suzie",
    birthday: "1990-03-02T08:00:00.000Z",
    created_at: "2015-01-26T18:48:31.142Z",
    city: "San Francisco",
    phone: "123-123-5555",
    user_id: 1,
    bio: "Line one\nLine two"
  }])
  visit("/clients/1")
  andThen =>
    ok(contains("#contact-name", "Suzie"))
    ok(contains("#contact-birthday", "March 2nd 1990"))
    ok(contains("#contact-user", "Kat"))
    ok(contains("#contact-from", "San Francisco"))
    ok(contains("#last-seen", "January 26th 2015"))
    ok(contains("#contact-phone", "123-123-5555"))
    ok(contains(".bio", "Line one<br>Line two"), find(".bio").html())
