`import Contact from 'grezha/models/contact'`

setupFixtures = ->
  Contact.reopenClass(
    FIXTURES: [
      { id: 'base', name: 'Smurfy' }
    ]
  )

`export default setupFixtures`
