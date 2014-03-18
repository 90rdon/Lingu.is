memberRoute = Ember.Route.extend
  model: (params) ->
    @store.find('member', params.member_id)
    
`export default memberRoute`