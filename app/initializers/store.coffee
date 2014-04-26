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