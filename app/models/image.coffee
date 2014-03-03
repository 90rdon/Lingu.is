attr      = DS.attr
hasMany   = DS.hasMany
belongsTo = DS.belongsTo

image = DS.Model.extend
  desc:     attr()
  path:     attr()
  member:   belongsTo('member')

image.reopenClass
  FIXTURES: [{
    "id": 1,
    "desc": "feature",
    "path": "assets/img/profiles/chinese/chinese1.jpg"
  }, {
    "id": 2,
    "desc": "feature",
    "path": "assets/img/profiles/chinese/chinese2.jpg"
  }, {
    "id": 3,
    "desc": "feature",
    "path": "assets/img/profiles/chinese/chinese3.jpg"
  }, {
    "id": 4,
    "desc": "feature",
    "path": "assets/img/profiles/portuguese/portuguese1.jpg"
  }, {
    "id": 5,
    "desc": "feature",
    "path": "assets/img/profiles/portuguese/portuguese2.jpg"
  }, {
    "id": 6,
    "desc": "feature",
    "path": "assets/img/profiles/portuguese/portuguese3.jpg"
  }, {
    "id": 7,
    "desc": "feature",
    "path": "assets/img/profiles/spanish/spanish1.jpg"
  }, {
    "id": 8,
    "desc": "feature",
    "path": "assets/img/profiles/spanish/spanish2.jpg"
  }, {
    "id": 9,
    "desc": "feature",
    "path": "assets/img/profiles/spanish/spanish3.jpg"
  }, {
    "id": 10,
    "desc": "feature",
    "path": "assets/img/profiles/russian/russian1.jpg"
  }, {
    "id": 11,
    "desc": "feature",
    "path": "assets/img/profiles/russian/russian2.jpg"
  }, {
    "id": 12,
    "desc": "feature",
    "path": "assets/img/profiles/russian/russian3.jpg"
  }]

`export default image`