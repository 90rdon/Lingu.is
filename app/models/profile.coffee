attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

profile   = FP.Model.extend
  identity:     attr()
  uid:          attr()
  uuid:         attr()
  provider:     attr()
  createdOn:    attr('date', default: -> new Date())

  priority: (->
    @get('uid')
  ).property('uid')

profile.reopenClass
  firebasePath: 'profile'

`export default profile`