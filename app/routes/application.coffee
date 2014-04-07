ApplicationRoute = Ember.Route.extend
  actions:
    login: (provider) ->
      @get('auth').login(provider)

    logout: ->
      @get('auth').logout()


# Ember.Route.reopen getParentRoute: ->
#   route = @
#   handlerInfos = route.router.router.currentHandlerInfos
#   parent = undefined
#   current = undefined
#   i = 0
#   l = handlerInfos.length

#   while i < l
#     current = handlerInfos[i].handler
#     return parent.routeName  if (current.routeName is route.routeName) or (current.routeName.match(/./) and current.routeName.split('.')[1] is route.routeName)
#     parent = current
#     i++
#   return


`export default ApplicationRoute`