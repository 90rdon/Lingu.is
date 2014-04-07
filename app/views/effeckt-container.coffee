effecktContainer = Ember.View.extend
  didInsertElement: ->
    self = @
    $(window).load ->
      $('.no-transitions').removeClass 'no-transitions'
      self.transitionEndEventName = self.transitionEndEventNames[Modernizr.prefixed('transition')]
      self.animationEndEventName = self.animationEndEventNames[Modernizr.prefixed('animation')]
      return

  animationEndEventNames:
    WebkitAnimation: 'webkitAnimationEnd'
    OAnimation: 'oAnimationEnd'
    msAnimation: 'MSAnimationEnd'
    animation: 'animationend'

  transitionEndEventNames:
    WebkitTransition: 'webkitTransitionEnd'
    OTransition: 'oTransitionEnd'
    msTransition: 'MSTransitionEnd'
    transition: 'transitionend'

  gestures:
    swipeLeft: (event) ->
      # do something like send an event down the controller/route chain
      @get('controller').transitionToRoute('index')

      false

`export default effecktContainer`