attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

session   = FP.Model.extend
  uuid:             attr()
  status:           attr()
  device:           attr()
  ip:               attr()
  meta:             attr()
  data:             attr()
  timestamp:        attr('date', default: -> new Date())

  priority: (->
    @get('uuid')
  ).property('uuid')

session.reopenClass
  firebasePath: 'session'
  
`export default session`