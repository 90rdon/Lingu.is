callController = Ember.ObjectController.extend
  init: ->
    self = @
    @set('store', App.__container__.lookup('store:main'))

`export default callController`