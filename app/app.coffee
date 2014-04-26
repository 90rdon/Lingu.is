`import Resolver        from 'ember/resolver'`
`import phoneGapApp     from 'linguis/phoneGapApp'`
`import authentication  from 'linguis/initializers/authentication'`
# `import store           from 'linguis/initializers/store'`
`import session         from 'linguis/initializers/session'`

Ember.Application.initializer(authentication)
Ember.Application.initializer(session)

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
  firebaseUri:              'https://linguis.firebaseio.com/'

  ready: ->
    @__container__.lookup('store:main').set('firebaseRoot', @get('firebaseUri'))

`export default App`