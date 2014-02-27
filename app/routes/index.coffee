indexRoute = Ember.Route.extend
  # model: ->
  # ['red', 'yellow', 'blue']
  
  setupController: ->
    @loadData()

  loadData: ->
    membersController = @controllerFor('members')

    @store.find('member').then (members) ->
      promises = members.map (member) ->
        Ember.RSVP.hash
          first: member.first
          last: member.last
          tagline: member.tagline
          bio: member.bio
          images: member.get('images').then (images) ->
            images.filter (image, index) ->
              image if index == 1
          profiles: member.get('profiles').then (profiles) ->
            profiles.filter (profile, index) ->
              profile if index == 1

      Ember.RSVP.all(promises).then (filteredMembers) ->
        membersController.set 'model', filteredMembers

`export default indexRoute`