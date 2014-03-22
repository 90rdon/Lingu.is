attr      = DS.attr
hasMany   = DS.hasMany
belongsTo = DS.belongsTo

member    = DS.Model.extend
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

  # images:     hasMany('image', { embedded: true })
  # profiles:   hasMany('profile', { embedded: true })

  fullName: (->
    first   = @get('first') || ''
    last    = @get('last') || ''

    return first + ' ' + last
  ).property('first', 'last')

  
`export default member`