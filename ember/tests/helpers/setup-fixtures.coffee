`import Contact from 'grezha/models/contact'`
`import Connection from 'grezha/models/connection'`

setupFixtures = ->
  Contact.reopenClass(
    FIXTURES: [
      {
        id: 'base',
        name: 'Smurfy',
      },
      {
        id: 'has-connections',
        name: 'Narbert',
        connections: [1, 2, 3]
      }
    ])

  Connection.reopenClass(
    FIXTURES: [
      { id: 1, note: 'lunch meeting', occurredAt: new Date(2013, 1, 1)}
      { id: 2, note: 'coffee', occurredAt: new Date(2013, 1, 2) }
      { id: 3, note: 'counseling', occurredAt: new Date(2013, 1, 3)}
    ])

`export default setupFixtures`
