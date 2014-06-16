sessionsInititalizer = 
  name: 'sessions'
  after: 'store'

  initialize: (container, application) ->
    sessions = container.lookup('controller:sessions')
    application.register 'sessions:main', sessions,
      instantiate: false
      singleton: true
    
    container.typeInjection 'route', 'sessions', 'sessions:main'
    container.typeInjection 'controller', 'sessions', 'sessions:main'
    container.typeInjection 'component', 'sessions', 'sessions:main'

`export default sessionsInititalizer`