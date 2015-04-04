`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module 'Contacts page integration test',
  setup: ->
    @app = startApp()
    @api = PretendApi.create().start()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)

test "shows number of clients assigned to each user", ->
  @api.set('users', [
    {id: 1, name: "Micheal Keaton", role: 'admin'}
    {id: 3, name: "Eddie Redmayne", role: 'admin'}
  ])

  @api.set('contacts', [
    {id: 1, name: "Sue", user_id: 1, role: 'client'},
    {id: 2, name: "Stu", user_id: 1, role: 'client'},
    {id: 3, name: "Shu", user_id: 1, role: 'client'},
    {id: 4, name: "Smu", user_id: 3, role: 'client'},
    {id: 5, name: "Tae", role: 'client'}
  ])

  visit("/clients/")
  andThen ->
    ok(contains('#field-ops tr:first-child', "Micheal Keaton"))
    ok(contains('#field-ops tr:first-child', "3"))
    ok(contains('#field-ops tr:nth-child(2)', "Eddie Redmayne"))
    ok(contains('#field-ops tr:nth-child(2)', "1"))
    ok(contains('#field-ops tr:last-child', "Unassigned"))
    ok(contains('#field-ops tr:last-child', "1"))

test "shows the number of connections in the dashboard", ->
  @api.set('contacts', [
    {id: 3, name: "Ms McGrethory", connection_ids: [1, 2]}
    {id: 4, name: "Sukirti", connection_ids: [3, 4]}
  ])

  @api.set('connections', [
    {id: 1, note: "test 1"},
    {id: 2, note: "test 2"},
    {id: 3, note: "test 3"},
    {id: 4, note: "test 4"}
  ])

  visit("/clients/")
  andThen ->
    ok(contains('.dashboard', "You've recorded <b>4</b>"))


test "client counter works", ->
  @api.set('contacts', [
    {id: 1, role: 'client'},
    {id: 2, role: 'client'},
    {id: 3, role: 'client'},
    {id: 7, role: 'client'}
  ])
  visit("/clients/")
  andThen =>
    ok(contains("#clients-link", "(4)"),
      "Number of total contacts should be in header")


test "shows all people in sidebar when no search query entered", ->
  @api.set('contacts', [
    {id: 1, name: "Cat", role: 'client'},
    {id: 2, name: "Sted", role: 'client'}
  ])
  visit("/clients/")
  andThen =>
    equal(find(".contact").length, 2,
      "shows all contacts in list")


test "shows only people matching role in sidebar", ->
  @api.set('contacts', [
    {id: 1, name: "Cat", role: 'client'},
    {id: 2, name: "Sted", role: 'client'}
    {id: 3, name: "Flash", role: 'volunteer'}
    {id: 4, name: "Sanjay", role: 'volunteer'}
  ])
  visit("/volunteers/")
  andThen =>
    equal(find(".contact").length, 2, "shows only volunteers in list")
    ok(contains(".contact:eq(0)", "Flash"), "shows volunteer names in list")


test "shows only people with matching string in name", ->
  @api.set('contacts', [
    {id: 1, role: 'client', name: "Cat"},
    {id: 2, role: 'client', name: "Cat Dog"},
    {id: 3, role: 'client', name: "Sted"}
  ])
  visit("/clients/")
  fillIn("#contact-search", "Cat")
  andThen ->
    equal(find(".contact").length, 2, "Should show matching on name")


test 'show only people in sidebar with matching user', ->
  @api.set('users', [{id: 0, name: "Pat Mims"},
                     {id: 1, name: "Marc Jan"}])
  @api.set('contacts', [
    {id: 1, role: 'client', name: 'New Boy',  user_id: 0},
    {id: 2, role: 'client', name: 'Hip Girl', user_id: 0},
    {id: 3, role: 'client', name: 'Old Dude', user_id: 1}
  ])
  visit("/clients/")
  fillIn("#contact-search", "Pat")
  andThen ->
    ok(contains(".contacts", "Hip Girl"))
    ok(contains(".contacts", "New Boy"))
    ok(!contains(".contacts", "Old Dude"))


test 'clicking on contact goes to contact page', ->
  @api.set('contacts', [{id: 1, role: 'client', name: "Cat"}])
  visit("/clients/")
  click('.contacts a')
  andThen -> equal(currentURL(), '/clients/1')


test 'adds contact with name in search bar', ->
  visit('/clients/')
  fillIn("#contact-search", "Hamilton")
  click('.new-contact a')
  andThen ->
    equal(currentPath(), 'contacts.new')
    equal(find('#name').val(), "Hamilton")