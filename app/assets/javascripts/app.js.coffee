loadContacts = ->
  return if !navigator.onLine 

  $.get '/contacts.json', (contacts)->
    names = (contact.name for contact in contacts)
    localStorage.contacts = JSON.stringify(names)


printContacts = ->
  contacts = JSON.parse(localStorage.contacts) ? []
  addContact contact for contact in contacts

addContact = (name)->
  $("ul#contacts").append "<li>#{name}</li>"

class App
  start: -> 
   loadContacts()
   printContacts()

window.app = new App