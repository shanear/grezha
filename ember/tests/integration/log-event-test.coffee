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

  visit("/events/big-events/past")
  click(".event a")
  andThen ->
    equal(currentURL(), "/events/1/log",
      "should navigate to log page instead of event page")