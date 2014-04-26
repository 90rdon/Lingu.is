indexRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('members').set 'content', @store.find('member')
    @controllerFor('profiles').set 'content', @store.find('profile')
   
`export default indexRoute`