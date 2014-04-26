sessionInititalizer = 
  name: 'session'
  after: 'store'

  initialize: (container, application) ->
    session = container.lookup('controller:session')
    application.register 'session:main', session,
      instantiate: false
      singleton: true
    
    container.typeInjection 'route', 'session', 'session:main'
    container.typeInjection 'controller', 'session', 'session:main'
    container.typeInjection 'component', 'session', 'session:main'

`export default sessionInititalizer`