effecktScrollController = Ember.ArrayController.extend
  needs: [
    'index'
  ]

  contentBinding: 'controllers.index.memberList'

`export default effecktScrollController`  