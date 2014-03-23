selfView = Ember.View.extend
  nav: []
  closeButton: []

  didInsertElement: ->
    @set('nav', $('#effeckt-off-screen-nav'))
    @set('closeButton', $('#effeckt-off-screen-nav-close'))
    @bindUIActions()

  bindUIActions: ->
    self = @
    $('#off-screen-nav-button, #effeckt-off-screen-nav-close, #member-nav-login').on 'click', ->
      type = $(this).data('effeckt')
      threedee = $(this).data('threedee')
      self.toggleNav type, threedee

  toggleNav: (type, threedee) ->
    self = @
    # Show
    unless self.nav.hasClass('effeckt-off-screen-nav-show')
      self.nav.addClass type
      self.closeButton.data 'effeckt', type
      $('html').addClass 'md-perspective'  if threedee
      setTimeout (->
        self.nav.addClass 'effeckt-off-screen-nav-show'
      ), 500
    
    # Hide
    else
      self.nav.removeClass 'effeckt-off-screen-nav-show'
      setTimeout (->
        self.nav.removeClass self.closeButton.data('effeckt')
        self.nav.hide()
        blah = self.nav.width()
        self.nav.show()
        $('html').removeClass 'md-perspective'
      ), 500

  actions:
    login: (provider) ->
      @toggleNav(undefined, undefined)
      @get('controller.auth').send('login', provider)

    logout: ->
      @toggleNav(undefined, undefined)
      @get('controller.auth').send('logout')

`export default selfView`