App.Contact = DS.Model.extend
  name: DS.attr('string'),
  city: DS.attr('string'),
  bio: DS.attr('string'),
  lastSeen: DS.attr('date'),
  birthday: DS.attr('date')

App.Contact.FIXTURES = [
  {
    id: 1,
    name: 'Sponge Bob',
    city: "Bikini Bottom",
    last_seen: new Date(),
    birthday: new Date(),
    bio: 'I live in a Pinapple under the sea. SPONGE. BOB. SQUARE. PANTS. I live in a pinapple under the sea! Sponge. Bob. Square. Pants.'
  }, {
    id: 2,
    name: 'Micah Russell',
    city: 'San Francisco',
    last_seen: new Date(),
    birthday: new Date(),
    bio: "I am the brother to Shane Russell. I'm a little bit of a bad ass, and I make special effects for a living. I make delicious food, and have a pretty mean hook shot. I am the brother to Shane Russell. I'm a little bit of a bad ass, and I make special effects for a living. I make delicious food, and have a pretty mean hook shot. I am the brother to Shane Russell. I'm a little bit of a bad ass, and I make special effects for a living. I make delicious food, and have a pretty mean hook shot."
  }, {
    id: 3,
    name: 'Douglass Douglass',
    city: "Washington DC"
    birthday: new Date(),
    last_seen: new Date(),
    bio: 'The future President of the United States!'
  }
]