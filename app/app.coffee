`import Resolver        from 'ember/resolver'`
`import phoneGapApp     from 'linguis/phoneGapApp'`
`import authentication  from 'linguis/initializers/authentication'`
`import connection      from 'linguis/initializers/connection'`

Ember.Application.initializer(connection)
Ember.Application.initializer(authentication)

App = Ember.Application.extend
  LOG_ACTIVE_GENERATION:    true
  LOG_MODULE_RESOLVER:      true
  LOG_TRANSITIONS:          true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS:         true
  modulePrefix:             'linguis'
  Resolver:                 Resolver['default']

App.reopen
  serverUri:                'http://0.0.0.0:3333/'
  phoneGapApp:                phoneGapApp
  firebaseUri:              'https://linguis.firebaseio.com/'

  ready: ->
    console.log 'App ready!! --- init firebaseUri ---'
    @__container__.lookup('store:main').set('firebaseRoot', @get('firebaseUri'))
    console.log 'App inited'

`export default App`

# storeInititalizer =
#   name: 'storeInject'

#   initialize: (container, application) ->
#     store = container.lookup('store:main')
#     store.reopen
#       firebaseRoot: 'https://linguis.firebaseio.com/'
#     application.register 'store:main', store,
#       instantiate: false
#       singleton: true

#     container.typeInjection 'route', 'store', 'store:main'
#     container.typeInjection 'controller', 'store', 'store:main'
#     container.typeInjection 'component', 'store', 'store:main'

# `export default storeInititalizer`
#
#