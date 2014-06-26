applicationController = Ember.ObjectController.extend
  needs: [
    'index'
    'authentication'
    'connection'
  ]

  init: ->
    @_super()
    console.log 'controller:application:init'

`export default applicationController`