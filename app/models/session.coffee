attr      = DS.attr
hasMany   = DS.hasMany
belongsTo = DS.belongsTo

session   = DS.Model.extend
  event:            attr()
  timestamp:        attr()
  memberId:         attr()
  device:           attr()
  ip:               attr()
  meta:             attr()
  data:             attr()
  
`export default session`