indexRoute = Ember.Route.extend
  init: ->
    @_super()
    @set('store', App.__container__.lookup('store:main'))

  setupController: ->
    self = @
    console.log 'route:index:setupController - members:before fetch'
    @store.fetch('member').then (members) ->
      self.controllerFor('members').set 'content', members
      console.log 'route:index:setupController - members:content set'
   
`export default indexRoute`