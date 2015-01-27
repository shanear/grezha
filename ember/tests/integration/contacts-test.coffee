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


test "shows all people in sidebar when no search query entered", ->
  @api.set('contacts', [{id: 1, name: "Cat"}, {id: 2, name: "Sted"}])
  visit("/clients/")
  andThen =>
    equal(find(".contact").length, 2,
      "shows all contacts in list")


test "shows only people with matching string in name", ->
  @api.set('contacts', [{id: 1, name: "Cat"}, {id: 2, name: "Cat Dog"}, {id: 3, name: "Sted"}])
  visit("/clients/")
  fillIn("#contact-search", "Cat")
  andThen ->
    equal(find(".contact").length, 2, "Should show matching on name")


test 'show only people in sidebar with matching user', ->
  @api.set('users', [{id: 0, name: "Pat Mims"},
                     {id: 1, name: "Marc Jan"}])
  @api.set('contacts', [{id: 1, name: 'New Boy',  user_id: 0},
                        {id: 2, name: 'Hip Girl', user_id: 0},
                        {id: 3, name: 'Old Dude', user_id: 1}])
  visit("/clients/")
  fillIn("#contact-search", "Pat")
  andThen ->
    ok(contains(".contacts", "Hip Girl"))
    ok(contains(".contacts", "New Boy"))
    ok(!contains(".contacts", "Old Dude"))


test 'clicking on contact goes to contact page', ->
  @api.set('contacts', [{id: 1, name: "Cat"}])
  visit("/clients/")
  click('.contacts a')
  andThen -> equal(currentURL(), '/clients/1')

