`import Resolver from 'ember/resolver'`
`import phoneGapApp from 'linguis/phoneGapApp'`
`import auth from 'linguis/controllers/auth'`

App = Ember.Application.extend
  LOG_ACTIVE_GENERATION:    true
  LOG_MODULE_RESOLVER:      true
  LOG_TRANSITIONS:          true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS:         true
  modulePrefix:             'linguis'
  Resolver:                 Resolver['default']

App.reopen
  phoneGapApp:              phoneGapApp
  FirebaseUri:              'https://linguis.firebaseio.com/'

  ready: ->
    @register 'main:auth', auth
    @inject   'route', 'auth', 'main:auth'
    @inject   'controller', 'auth', 'main:auth'

`export default App`