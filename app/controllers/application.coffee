applicationController = Ember.ObjectController.extend
  needs: [
    'index'
    'authentication'
    'sessions'
  ]

  init: ->
    @_super()
    console.log 'controller:application:init'

`export default applicationController`