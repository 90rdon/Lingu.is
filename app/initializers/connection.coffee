connectionInititalizer = 
  name: 'connection'
  after: 'store'

  initialize: (container, application) ->
    connection = container.lookup('controller:connection')
    application.register 'connection:main', connection,
      instantiate: false
      singleton: true
    
    container.typeInjection 'route', 'connection', 'connection:main'
    container.typeInjection 'controller', 'connection', 'connection:main'
    container.typeInjection 'component', 'connection', 'connection:main'

`export default connectionInititalizer`