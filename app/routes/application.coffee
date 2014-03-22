ApplicationRoute = Ember.Route.extend
  actions:
    login: (provider) ->
      @get('auth').login(provider)

    logout: ->
      @get('auth').logout()

`export default ApplicationRoute`