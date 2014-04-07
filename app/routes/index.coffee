indexRoute = Ember.Route.extend
  setupController: ->
    console.log 'parent = ' + @getParentRoute()
    @controllerFor('members').set 'content', @store.find('member')

`export default indexRoute`