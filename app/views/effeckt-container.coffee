effecktContainer = Ember.View.extend
  didInsertElement: ->
    self = @
    $(window).load ->
      $('.no-transitions').removeClass 'no-transitions'
      self.transitionEndEventName = self.transitionEndEventNames[Modernizr.prefixed('transition')]
      self.animationEndEventName = self.animationEndEventNames[Modernizr.prefixed('animation')]
      return

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

`export default effecktContainer`