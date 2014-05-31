memberRoute = Ember.Route.extend
  model: (params) ->
    console.log 'route:member:model'
    @store.find('member', params.member_id)

  actions:
    willTransition: (transition) ->
      console.log 'in transition'
    
`export default memberRoute`