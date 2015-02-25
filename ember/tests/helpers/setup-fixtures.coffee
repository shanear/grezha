`import Contact from 'grezha/models/contact'`
`import Connection from 'grezha/models/connection'`
`import Person from 'grezha/models/person'`
`import Vehicle from 'grezha/models/vehicle'`
`import User from 'grezha/models/user'`

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

  Person.reopenClass(
    FIXTURES: [
      { id: 'base', name: "Mr McGrethory",  role: "husband" }
    ])

  Vehicle.reopenClass(
    FIXTURES: [
      {id: 'base', licensePlate: "license"}
    ])

  User.reopenClass(
    FIXTURES: [
      { id: 'base', name: "Sir Charles Barkley" }
    ])
`export default setupFixtures`
