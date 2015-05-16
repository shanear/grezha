`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Vehicles page test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)


test "should display license plate on the vehicles list page", ->
  @api.set("vehicles", [{id: 1,licensePlate: "PLATE1", usedBy:"Sketchy Dude", notes: "Whee"}])
  visit("/vehicles/")
  andThen =>
    ok(contains(".vehicle", "PLATE1"))