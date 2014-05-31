applicationController = Ember.ObjectController.extend
  needs: [
    'index'
    'authentication'
  ]

  init: ->
    @_super()
    console.log 'controller:application:init'

`export default applicationController`