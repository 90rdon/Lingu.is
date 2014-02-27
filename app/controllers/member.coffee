memberController = Ember.ObjectController.extend
  needs: [
    'index'
  ]

  search: (->
    @get('controllers.index.search')
  ).property()

  searchMatched: (->
    regexp = new RegExp(@get('search'))
    profiles = @get('profiles')
    isTrue = profiles.some (profile) ->
      regexp.test profile.get('to')
    # @get('profiles').anyBy('to', @get('search'))
    console.log isTrue
    isTrue
  ).property('search', 'profiles')

`export default memberController`