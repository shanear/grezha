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
    ok(/Hip Girl/.test(find(".contact").text()), "Should contain Hip Girl")
    ok(/New Boy/.test(find(".contact").text()), "Should contain New Boy")
    ok(!/Old Dude/.test(find(".contact").text()), "Should not contain old dude since different user")

