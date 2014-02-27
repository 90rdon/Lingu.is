navbarAffixView = Ember.View.extend
  didInsertElement: ->
    $('#nav-wrapper').height($('#linguis-navigation').height())
    $('#linguis-navigation').affix
      offset: $('#linguis-navigation').position()
    
    $('.ember-text-field').focus(->
      $(this).attr('data-default', $(this).width())
      $(this).animate({ width: 700 }, 'slow')
    )
    $('.ember-text-field').blur(->
      w = $(this).attr('data-default')
      w = + w + 34
      $(this).animate({ width: w }, 'slow')
      $(this).parent().animate({ width: w }, 'slow')
    )

`export default navbarAffixView`