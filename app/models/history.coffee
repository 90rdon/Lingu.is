attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

history   = FP.Model.extend
  uuid:             attr()
  status:           attr()
  device:           attr()
  ip:               attr()
  meta:             attr()
  data:             attr()
  on:               attr('date', default: -> Firebase.ServerValue.TIMESTAMP)
  off:              attr('date', default: -> null)

  priority: (->
    @get('uuid')
  ).property('uuid')

  onTime: (->
    new Date((@get('on') * 1000) + ' UTC').toString()
  ).property('on')

  offTime: (->
    new Date((@get('off') * 1000) + ' UTC').toString()
  ).property('off')

history.reopenClass
  firebasePath: 'history'
  
`export default history`