memberRoute = Ember.Route.extend
  model: (params) ->
    @store.find('member', params.member_id)

  actions:
    willTransition: (transition) ->
      console.log 'in transition'
    
`export default memberRoute`