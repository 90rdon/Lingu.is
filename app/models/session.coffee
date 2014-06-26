attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

session = FP.Model.extend
  uuid:             attr()
  status:           attr()
  device:           attr()
  ip:               attr()
  meta:             attr()
  data:             attr()
  on:               attr()
  off:              attr()
  logon:            attr()
  logoff:           attr()

  priority: (->
    @get('uuid')
  ).property('uuid')

  # onTime: (->
  #   new Date((@get('on') * 1000) + ' UTC').toString()
  # ).property('on')

  # offTime: (->
  #   new Date((@get('off') * 1000) + ' UTC').toString()
  # ).property('off')

session.reopenClass
  firebasePath: 'session'
  
`export default session`