`import Resolver from 'resolver'`
`import phoneGapApp from 'appkit/phoneGapApp'`

App = Ember.Application.extend
  LOG_ACTIVE_GENERATION:    true
  LOG_MODULE_RESOLVER:      true
  LOG_TRANSITIONS:          true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS:         true
  modulePrefix:             'appkit'
  Resolver:                 Resolver['default']

App.reopen
  phoneGapApp: phoneGapApp

`export default App`