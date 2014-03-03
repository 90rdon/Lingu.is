attr      = DS.attr
hasMany   = DS.hasMany
belongsTo = DS.belongsTo

profile = DS.Model.extend
  from:     attr()
  to:       attr()
  tagline:  attr()
  rate:     attr()
  likes:    attr()
  member:   belongsTo('member')

profile.reopenClass
  FIXTURES: [
    {
      "id": 1,
      "from": "chinese",
      "to": "spanish",
      "rate": 2.2,
      "likes": 5
    },
    {
      "id": 2,
      "from": "chinese",
      "to": "english",
      "rate": 2,
      "likes": 202
    },
    {
      "id": 3,
      "from": "chinese",
      "to": "english",
      "rate": 3.1,
      "likes": 15
    },
    {
      "id": 4,
      "from": "chinese",
      "to": "english",
      "rate": 1.5,
      "likes": 412
    },
    {
      "id": 5,
      "from": "portuguese",
      "to": "spanish",
      "rate": 1.25,
      "likes": 50
    },
    {
      "id": 6,
      "from": "portuguese",
      "to": "english",
      "rate": 2.5,
      "likes": 20
    },
    {
      "id": 7,
      "from": "portuguese",
      "to": "english",
      "rate": 2.2,
      "likes": 156
    },
    {
      "id": 8,
      "from": "portuguese",
      "to": "english",
      "rate": 3.5,
      "likes": 4
    },
    {
      "id": 9,
      "from": "spanish",
      "to": "english",
      "rate": 1.5,
      "likes": 76
    },
    {
      "id": 10,
      "from": "spanish",
      "to": "english",
      "rate": 4.5,
      "likes": 28
    },
    {
      "id": 11,
      "from": "spanish",
      "to": "english",
      "rate": 1.5,
      "likes": 233
    },
    {
      "id": 12,
      "from": "russian",
      "to": "english",
      "rate": 5,
      "likes": 8
    },
    {
      "id": 13,
      "from": "ukrainian",
      "to": "english",
      "rate": 5,
      "likes": 2
    },
    {
      "id": 14,
      "from": "russian",
      "to": "english",
      "rate": 8,
      "likes": 812
    },
    {
      "id": 15,
      "from": "russian",
      "to": "english",
      "rate": 25,
      "likes": 11812
    }
  ]

`export default profile`