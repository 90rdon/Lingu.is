callRoute = Ember.Route.extend
  init: ->
    @_super()
    @set('store', App.__container__.lookup('store:main'))

  model: (params) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      self.store.fetch('call', params.call_id).then (callRef) ->
        resolve(callRef)
      , (notFound) ->
        ic.ajax(App.serverUri + 'token/' + params.call_id).then ->
          self.store.fetch('call', params.call_id).then (callRef) ->
            resolve(callRef)    

  actions:
    willTransition: (transition) ->
      console.log 'in transition'
    
`export default callRoute`