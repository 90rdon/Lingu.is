memberRoute = Ember.Route.extend
  model: (params) ->
    @store.find('member', params.member_id).then (member) ->
      promises = Ember.RSVP.hash
        first: member.get('first')
        last: member.get('last')
        fullName: member.get('fullName')
        tagline: member.get('tagline')
        bio: member.get('bio')
        images: member.get('images').then (images) ->
          images.map (image) ->
            image
        profiles: member.get('profiles').then (profiles) ->
          profiles.map (profile) ->
            profile

  setupController: (controller, model) ->
    controller.set 'model', model

`export default memberRoute`