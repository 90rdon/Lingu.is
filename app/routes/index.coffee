indexRoute = Ember.Route.extend
  setupController: ->
    @loadData()

  loadData: ->
    membersController = @controllerFor('members')

    @store.find('member').then (members) ->
      promises = members.map (member) ->
        Ember.RSVP.hash
          id:       member.get('id')
          first:    member.get('first')
          last:     member.get('last')
          fullName: member.get('fullName')
          tagline:  member.get('tagline')
          bio:      member.get('bio')
          images:   member.get('images').then (images) ->
            images.filter (image, index) ->
              image if index == 0
          profiles: member.get('profiles').then (profiles) ->
            profiles.filter (profile, index) ->
              profile if index == 0

      Ember.RSVP.all(promises).then (filteredMembers) ->
        membersController.set 'model', filteredMembers

`export default indexRoute`