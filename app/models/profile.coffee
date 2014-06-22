attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

profile   = FP.Model.extend
  identity:     attr()
  uid:          attr()
  uuid:         attr()
  provider:     attr()
  createdOn:    attr('date', default: -> Firebase.ServerValue.TIMESTAMP)

  priority: (->
    @get('uid')
  ).property('uid')

  # id: (->
  #   @get('id')
  # ).property('id')

profile.reopenClass
  firebasePath: 'profile'

`export default profile`