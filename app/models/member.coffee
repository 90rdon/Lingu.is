attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

member    = FP.Model.extend
  first:            attr()
  last:             attr()
  displayName:      attr()
  name:             attr()
  tagline:          attr()
  bio:              attr()
  image:            attr()
  favourites_count: attr()
  followers_count:  attr()
  friends_count:    attr()
  url:              attr()
  createdOn:        attr('date', default: -> new Date())

  profiles:         hasMany('profile', embedded: false)

  connected: (->
    @get('id')
  ).property('id')

  fullName: (->
    first   = @get('first') || ''
    last    = @get('last') || ''

    return first + ' ' + last
  ).property('first', 'last')

member.reopenClass
  firebasePath: 'member'
  
`export default member`