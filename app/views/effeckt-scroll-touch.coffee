`import effecktScrollItem from 'linguis/app/views/effeckt-scroll-item'`

effecktListScrollTouch = effecktListScrollItem.extend
  element: null
  top: null
  touch: null
  velocity: 0

  init: (element) ->
    @_super()
    @set('element', element)
    @set(@get('element.style.overflow'), 'hidden')

    @set('top', 
      value: 0
      natural: 0
    )

    @set('touch',
      value: 0
      offset: 0
      start: 0
      previous: 0
      lastMove: Date.now()
      accellerateTimeout: -1
      isAccellerating: false
      isActive: false
    )

    @set('velocity', 0)

  ###
  Fetches the latest properties from the DOM to ensure that
  this list is in sync with its contents. This is typically
  only used once (per list) at initialization.
  ###
  sync: ->
    @items = Array::slice.apply(@element.children)
    @listHeight = @element.offsetHeight
    item = undefined
    
    # One loop to get the properties we need from the DOM
    i = 0
    len = @items.length

    while i < len
      item = @items[i]
      item._offsetHeight = item.offsetHeight
      item._offsetTop = item.offsetTop
      item._offsetBottom = item._offsetTop + item._offsetHeight
      item._state = ''
      
      # Animating opacity is a MAJOR performance hit on mobile so we can't allow it
      item.style.opacity = 1
      i++
    @top.natural = @element.scrollTop
    @top.value = @top.natural
    @top.max = item._offsetBottom - @listHeight
    
    # Force an update
    @update true
    @bind()
    return

  
  ###
  Binds the events for this list. References to proxy methods
  are kept for unbinding if the list is disposed of.
  ###
  bind: ->
    scope = this
    @touchStartDelegate = (event) ->
      scope.onTouchStart event
      return

    @touchMoveDelegate = (event) ->
      scope.onTouchMove event
      return

    @touchEndDelegate = (event) ->
      scope.onTouchEnd event
      return

    @element.addEventListener 'touchstart', @touchStartDelegate, false
    @element.addEventListener 'touchmove', @touchMoveDelegate, false
    @element.addEventListener 'touchend', @touchEndDelegate, false
    return

  onTouchStart: (event) ->
    event.preventDefault()
    if event.touches.length is 1
      @touch.isActive = true
      @touch.start = event.touches[0].clientY
      @touch.previous = @touch.start
      @touch.value = @touch.start
      @touch.offset = 0
      if @velocity
        @touch.isAccellerating = true
        scope = this
        @touch.accellerateTimeout = setTimeout(->
          scope.touch.isAccellerating = false
          scope.velocity = 0
          return
        , 500)
      else
        @velocity = 0
    return

  onTouchMove: (event) ->
    if event.touches.length is 1
      previous = @touch.value
      @touch.value = event.touches[0].clientY
      @touch.lastMove = Date.now()
      sameDirection = (@touch.value > @touch.previous and @velocity < 0) or (@touch.value < @touch.previous and @velocity > 0)
      if @touch.isAccellerating and sameDirection
        clearInterval @touch.accellerateTimeout
        
        # Increase velocity significantly
        @velocity += (@touch.previous - @touch.value) / 10
      else
        @velocity = 0
        @touch.isAccellerating = false
        @touch.offset = Math.round(@touch.start - @touch.value)
      @touch.previous = previous
    return

  onTouchEnd: (event) ->
    distanceMoved = @touch.start - @touch.value
    
    # Apply velocity based on the start position of the touch
    @velocity = (@touch.start - @touch.value) / 10  unless @touch.isAccellerating
    
    # Don't apply any velocity if the touch ended in a still state
    @velocity = 0  if Date.now() - @touch.lastMove > 200 or Math.abs(@touch.previous - @touch.value) < 5
    @top.value += @touch.offset
    
    # Reset the variables used to determne swipe speed
    @touch.offset = 0
    @touch.start = 0
    @touch.value = 0
    @touch.isActive = false
    @touch.isAccellerating = false
    clearInterval @touch.accellerateTimeout
    
    # If a swipe was captured, prevent event propagation
    event.preventDefault()  if Math.abs(@velocity) > 4 or Math.abs(distanceMoved) > 10
    return

  
  ###
  Apply past/future classes to list items outside of the viewport
  ###
  update: (force) ->
    
    # Determine the desired scroll top position
    scrollTop = @top.value + @velocity + @touch.offset
    
    # Only scroll the list if there's input
    if @velocity or @touch.offset
      
      # Scroll the DOM and add on the offset from touch
      @element.scrollTop = scrollTop
      
      # Keep the scroll value within bounds
      scrollTop = Math.max(0, Math.min(@element.scrollTop, @top.max))
      
      # Cache the currently set scroll top and touch offset
      @top.value = scrollTop - @touch.offset
    
    # If there is no active touch, decay velocity
    @velocity *= 0.95  if not @touch.isActive or @touch.isAccellerating
    
    # Cut off early, the last fraction of velocity doesn't have 
    # much impact on movement
    @velocity = 0  if Math.abs(@velocity) < 0.15
    
    # Only proceed if the scroll position has changed
    if scrollTop isnt @top.natural or force
      @top.natural = scrollTop
      @top.value = scrollTop - @touch.offset
      scrollBottom = scrollTop + @listHeight
      
      # One loop to make our changes to the DOM
      i = 0
      len = @items.length

      while i < len
        item = @items[i]
        
        # Above list viewport
        if item._offsetBottom < scrollTop
          
          # Exclusion via string matching improves performance
          if @velocity <= 0 and item._state isnt 'past'
            item.classList.add 'past'
            item._state = 'past'
        
        # Below list viewport
        else if item._offsetTop > scrollBottom
          
          # Exclusion via string matching improves performance
          if @velocity >= 0 and item._state isnt 'future'
            item.classList.add 'future'
            item._state = 'future'
        
        # Inside of list viewport
        else if item._state
          item.classList.remove 'past'  if item._state is 'past'
          item.classList.remove 'future'  if item._state is 'future'
          item._state = ''
        i++
    return

  
  ###
  Cleans up after this list and disposes of it.
  ###
  destroy: ->
    @_super()
    @element.removeEventListener 'touchstart', @touchStartDelegate, false
    @element.removeEventListener 'touchmove', @touchMoveDelegate, false
    @element.removeEventListener 'touchend', @touchEndDelegate, false
    return
  
`export default effecktScrollTouch`