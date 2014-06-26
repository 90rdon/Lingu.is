attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

connection    = FP.Model.extend
  status:           attr()
  device:           attr()
  ip:               attr()
  meta:             attr()
  data:             attr()
  on:               attr()
  off:              attr()

  priority: (->
    @get('uuid')
  ).property('uuid')

  onTime: (->
    new Date((@get('on') * 1000) + ' UTC').toString()
  ).property('on')

  offTime: (->
    new Date((@get('off') * 1000) + ' UTC').toString()
  ).property('off')

connection.reopenClass
  firebasePath: 'connection'
  
`export default connection`