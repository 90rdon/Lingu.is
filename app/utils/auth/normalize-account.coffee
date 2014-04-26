normalizeAccount =
  # ----------------------------------------
  # Twitter
  # ----------------------------------------
  Twitter: (profileRef) ->
    profile = profileRef.toFirebaseJSON() 
    user = Ember.Object.create
      id:               profile.uuid
      first:            ''
      last:             ''
      displayName:      profile.identity.displayName || ''
      name:             profile.identity.name
      tagline:          profile.identity.description
      bio:              ''
      image:            profile.identity.profile_image_url
      favourites_count: profile.identity.favourites_count
      followers_count:  profile.identity.followers_count
      friends_count:    profile.identity.friends_count
      url:              profile.identity.url
      profiles:         []
      
    user.get('profiles').addObject(profileRef)
    user


  # ----------------------------------------
  # Github
  # ----------------------------------------
  Github: (profileRef) ->
    profile = profileRef.toFirebaseJSON() 
    user = Ember.Object.create
      id:               profile.uuid
      first:            ''
      last:             ''
      displayName:      profile.identity.displayName || profile.identity.username || ''
      name:             profile.identity.name || profile.identity.username
      tagline:          ''
      bio:              profile.identity.bio || ''
      image:            profile.identity.avatar_url
      favourites_count: 0
      followers_count:  profile.identity.followers
      friends_count:    0
      emails:           profile.identity.emails
      url:              profile.identity.url
      profiles:         []

    user.get('profiles').addObject(profileRef)
    user


  # ----------------------------------------
  # facebook
  # ----------------------------------------
  Facebook: (profileRef) ->
    profile = profileRef.toFirebaseJSON() 
    user = Ember.Object.create
      id:               profile.uuid
      first:            profile.identity.first_name || ''
      last:             profile.identity.last_name || ''
      displayName:      profile.identity.displayName || profile.identity.username || ''
      name:             profile.identity.name || ''
      tagline:          ''
      bio:              ''
      image:            0
      favourites_count: 0
      followers_count:  0
      friends_count:    0
      emails:           ''
      url:              profile.identity.link
      profiles:         []

    user.get('profiles').addObject(profileRef)
    user


`export default normalizeAccount`