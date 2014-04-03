# gestureManager = Ember.Object.extend
#   init: (el) ->
    
#     # el needs to be a jQuery element
#     @el = el
    
#     # helper for desktop simulation
#     # pressing the alt key will simulate
#     # a second finger in a gesture
#     keys = alt: false
#     $('body').keydown (e) ->
#       keys['alt'] = e.altKey and e.altKey
#       return

    
#     #console.log(keys)
#     $('body').keyup (e) ->
#       keys['alt'] = e.altKey and e.altKey
#       return

    
#     #console.log(keys)
#     @keys = keys
    
#     # setup hammer js listeners
    
#     # needed, because by default only 1 point
#     # gestures are accessible
#     @hammerConf                 = swipe_max_touches: 2
#     @boundHandleSwipeLeft       = _.bind(@handleSwipeLeft, this)
#     @boundHandleSwipeRight      = _.bind(@handleSwipeRight, this)
#     @boundHandleSwipeDown       = _.bind(@handleSwipeDown, this)
#     @boundHandleDragDown        = _.bind(@handleDragDown, this)
#     @boundHandleDragUp          = _.bind(@handleDragUp, this)
#     @el.hammer(@hammerConf).on 'swipeleft', @boundHandleSwipeLeft
#     @el.hammer(@hammerConf).on 'swiperight', @boundHandleSwipeRight
#     @el.hammer(@hammerConf).on 'swipedown', @boundHandleSwipeDown
#     @el.hammer(@hammerConf).on 'dragdown', @boundHandleDragDown
#     @el.hammer(@hammerConf).on 'dragup', @boundHandleDragUp
#     return

#   destroy: ->
#     @el.hammer(@hammerConf).off 'swipeleft', @boundHandleSwipeLeft
#     @el.hammer(@hammerConf).off 'swiperight', @boundHandleSwipeRight
#     @el.hammer(@hammerConf).off 'swipedown', @boundHandleSwipeDown
#     @el.hammer(@hammerConf).off 'dragdown', @boundHandleDragDown
#     @el.hammer(@hammerConf).off 'dragup', @boundHandleDragUp
#     @boundHandleSwipeLeft       = null
#     @boundHandleSwipeRight      = null
#     @boundHandleSwipeDown       = null
#     @boundHandleDragDown        = null
#     @boundHandleDragUp          = null
#     return

#   isTwoFinger: (e) ->
#     multiPoint = e.gesture.touches.length > 1
    
#     #console.log('points:', e.gesture.touches.length)
#     multiPoint = true  if @keys['alt'] is true
#     multiPoint

#   handleSwipeLeft: (e) ->
#     e.type = (if @isTwoFinger(e) then 'swipeLeftTwoFinger' else 'swipeLeft')
#     @el.trigger e
#     return

#   handleSwipeRight: (e) ->
#     e.type = (if @isTwoFinger(e) then 'swipeRightTwoFinger' else 'swipeRight')
#     @el.trigger e
#     return

#   handleSwipeDown: (e) ->
#     e.type = (if @isTwoFinger(e) then 'swipeDownTwoFinger' else 'swipeDown')
#     @el.trigger e
#     return

#   handleDragDown: (e) ->
#     e.type = (if @isTwoFinger(e) then 'dragDownTwoFinger' else 'dragDown')
#     @el.trigger e
#     return

#   handleDragUp: (e) ->
#     e.type = (if @isTwoFinger(e) then 'dragUpTwoFinger' else 'dragUp')
#     @el.trigger e
#     return

# `export default gestureManager`