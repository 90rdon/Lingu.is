historyController = Ember.ArrayController.extend
  init: ->
    @set('store', App.__container__.lookup('store:main'))

  actions:
    add: (session) ->
      @store.createRecord('history', session).save()

`export default historyController`