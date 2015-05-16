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
  vehicles = [{id: 1,licensePlate: "PLATE1", usedBy:"Sketchy Dude", notes: "Whee"},{id: 2,licensePlate: "PLATE2", usedBy:"Jon Weasley", notes: "He's ok"} ]
  @api.set("vehicles", vehicles)
  visit("/vehicles/")
  andThen =>
    ok(contains(".vehicle:nth-child(1)", "PLATE1"))
    ok(contains(".vehicle:nth-child(2)", "PLATE2"))

test "should display license plate details when going to specific license plate", ->
  @api.set("vehicles", [{id: 1,licensePlate: "PLATE1", usedBy:"Sketchy Dude", notes: "Whee"}])
  visit("/vehicles/1")
  andThen =>
    ok(contains(".vehicle-panel", "PLATE1"))
    ok(contains(".vehicle-panel", "Sketchy Dude"))
    ok(contains(".vehicle-panel", "Whee"))

test "should make new vehicle", ->
  visit("/vehicles/")
  fillIn("#vehicle-search", "NEWPLATE1")
  click(".new-vehicle .btn")
  fillIn("#licensePlate", "NEWPLATE1")
  fillIn("#usedBy","Mr Burns")
  fillIn("#notes","Was pitch black")
  click("#saveVehicle")
  andThen =>
    ok(contains(".vehicle-panel", "NEWPLATE1"))
    ok(contains(".vehicle-panel", "Mr Burns"))
    ok(contains(".vehicle-panel", "Was pitch black"))

test "should edit vehicle", ->
  @api.set("vehicles", [{id: 1,licensePlate: "PLATE1", usedBy:"Sketchy Dude", notes: "Whee"}])
  visit("/vehicles/1")
  click(".icon-pencil")
  fillIn("#usedBy","Ned Flanders")
  click("#saveVehicle")
  andThen =>
    ok(contains(".vehicle-panel", "PLATE1"))
    ok(contains(".vehicle-panel", "Ned Flanders"))
    ok(contains(".vehicle-panel", "Whee"))

test "should not create new vehicle and show error message if license plate empty", ->
  visit("/vehicles/")
  fillIn("#vehicle-search", "NEWPLATE1")
  click(".new-vehicle .btn")
  fillIn("#licensePlate", "NEWPLATE1")
  fillIn("#usedBy","Mr Burns")
  fillIn("#notes","Was pitch black")
  fillIn("#licensePlate", "")
  click("#saveVehicle")
  andThen =>
    ok(contains(".errors", "License plate is blank"))
    ok(@api.savedVehicle == null)

test "should search vehicles by license plate", ->
  vehicles = [{id: 1,licensePlate: "PLATE1", usedBy:"Sketchy Dude", notes: "Whee"},{id: 2,licensePlate: "PLATE2", usedBy:"Jon Weasley", notes: "He's ok"},{id: 3,licensePlate: "PLATE2000", usedBy:"Jon Weasley", notes: "He's ok"} ]
  @api.set("vehicles", vehicles)
  visit("/vehicles/")
  fillIn("#vehicle-search", "PLATE2")
  andThen =>
    ok(contains(".vehicle:nth-child(1)", "PLATE2"))
    ok(contains(".vehicle:nth-child(2)", "PLATE2000"))