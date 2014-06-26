authenticationInititalizer =
  name: 'authentication'
  after: 'store'

  initialize: (container, application) ->
    authentication = container.lookup('controller:authentication')
    application.register 'authentication:main', authentication,
      instantiate: false
      singleton: true

    container.typeInjection 'route', 'authentication', 'authentication:main'
    container.typeInjection 'controller', 'authentication', 'authentication:main'
    container.typeInjection 'component', 'authentication', 'authentication:main'

`export default authenticationInititalizer`