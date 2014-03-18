indexRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('members').set 'content', @store.find('member')

`export default indexRoute`