attr      = FP.attr
hasOne    = FP.hasOne
hasMany   = FP.hasMany
belongsTo = FP.belongsTo

call      = FP.Model.extend
  from:             attr()
  to:               attr()
  declined:         attr()
  reason:           attr()
  start:            attr()
  end:              attr()
  token:            attr()

call.reopenClass
  firebasePath: 'call'
  
`export default call`