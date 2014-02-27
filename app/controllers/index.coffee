indexController = Ember.ObjectController.extend
  needs: [
    'members'
  ]

  search:         null
  currentContent: Em.A([])

  membersIsLoaded: (->
    console.log 'controller:index - membersIsLoaded'
    @set('currentContent', @get('controllers.members.content'))
  ).observes('controllers.members.content.isLoaded')

  searching: (->
    console.log 'searching - ' + @get('search')
    @get('filtered')
  ).observes('search')

  sorted: (->
    console.log 'sorted'
    result = Em.ArrayProxy.createWithMixins Em.SortableMixin,
      content:@get('filteredContent')
      sortProperties: @get('sortProperties')
      sortAscending: @get('sortAscending')
    @set('currentContent', result)
  ).observes('arrangedContent', 'sortAscending')

  changed: (->
    @get('filtered')
  ).observes('content.@each')

  filteredContent: (->
    console.log 'filteredContent'
    regexp = new RegExp(@get('search'))
    result = @get('controllers.members').filter (item) ->
      regexp.test item.get('first')
  ).property('search', 'controllers.members.@each.first')

  filtered: (->
    console.log 'filtered'
    result = Em.ArrayProxy.createWithMixins Em.SortableMixin,
      content:@get('filteredContent')
      sortProperties: @get('sortProperties')
      sortAscending: @get('sortAscending')
    @set('currentContent', result)
  ).property('filteredContent')

`export default indexController`