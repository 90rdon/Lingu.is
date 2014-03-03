slideMenuView = Ember.View.extend
  didInsertElement: ->
    console.log 'On load'
    slideMenuButton = document.getElementById('slide-menu-button')
    slideMenuButton.onclick = (e) ->
      cl = document.body.classList
      if cl.contains('left-nav')
        cl.remove 'left-nav'
      else
        cl.add 'left-nav'
      return

    # @showView 'button-bar-tpl'
    # tab = document.getElementById('tab1')
    # tab.classList.add 'is-active'

`export default slideMenuView`