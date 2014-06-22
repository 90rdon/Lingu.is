applicationController = Ember.ObjectController.extend
  needs: [
    'index'
    'authentication'
    'session'
  ]

  init: ->
    @_super()
    console.log 'controller:application:init'

`export default applicationController`