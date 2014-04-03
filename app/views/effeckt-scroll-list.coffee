effecktScrollView = Ember.CollectionView.extend
  tagName: 'ul'

  classNames: [
    'topcoat-list__container'
    'effeckt-list-scroll'
    'list-fly'
  ]

  attributeBindings: [ 'data-effeckt' ]
  # IS_TOUCH_DEVICE: !!('ontouchstart' of window)
  itemViewClass: 'effeckt-scroll-item'
  contentBinding: 'controller'

  didInsertElement: ->
    stroll.bind(@$())

`export default effecktScrollView`