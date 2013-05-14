class App.Contacts extends Spine.Controller
  className: "contacts"

  constructor: ->
    super
    App.Contact.bind 'refresh', @render
    App.Contact.ajaxFetch()

  render: =>
    contacts = App.Contact.all()
    @html @view("contacts/index")(contacts: contacts)

###
class App.Contacts extends Spine.Stack
  className: 'contacts stack'

  controllers:
    index: Index

  routes:
    '': 'index'
###