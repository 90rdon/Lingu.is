`import uuid from 'linguis/utils/uuid'`

authController = Ember.Controller.extend
  needs: [
    'member'
  ]

  currentMember: null
  allowed: false

  authChange: (->
    if @get('currentMember') then @set('allowed', true) else @set('allowed', false)
  ).observes('currentMember')

  init: ->
    self = @
    dbRef = new Firebase App.FirebaseUri
    @authClient = new FirebaseSimpleLogin(dbRef, ((error, authUser) ->
      # --- error ---
      if error
        self.set('currentMember', null)

      # --- authenticated ---
      else if authUser
        switch authUser.provider
          when 'twitter' then self.authenticateUser authUser, self.normalizeTwitterUser
          when 'github' then self.authenticateUser authUser, self.normalizeGithubUser
          when 'facebook' then self.authenticateUser authUser, self.normalizeFacebookUser
          
      # --- default ---
      else
        self.set('currentMember', null)

    ).bind(@))


  
  # ----------------------------------------
  # Twitter
  # ----------------------------------------
  normalizeTwitterUser: (twitterUser) ->
    id:               uuid.createUuid()
    profiles:         {
      providerId:     twitterUser.uid
    }
    first:            ''
    last:             ''
    displayName:      twitterUser.displayName || ''
    name:             twitterUser.name
    tagline:          twitterUser.description
    bio:              ''
    image:            twitterUser.profile_image_url
    favourites_count: twitterUser.favourites_count
    followers_count:  twitterUser.followers_count
    friends_count:    twitterUser.friends_count
    url:              twitterUser.url

  # ----------------------------------------
  # Github
  # ----------------------------------------
  normalizeGithubUser: (githubUser) ->
    id:               uuid.createUuid()
    profiles:         {
      providerId:     githubUser.uid
    }
    first:            ''
    last:             ''
    displayName:      githubUser.displayName || githubUser.username || ''
    name:             githubUser.name || git
    tagline:          ''
    bio:              githubUser.bio || ''
    image:            githubUser.avatar_url
    favourites_count: 0
    followers_count:  githubUser.followers
    friends_count:    0
    emails:           githubUser.emails
    url:              githubUser.url

  # ----------------------------------------
  # facebook
  # ----------------------------------------
  normalizeFacebookUser: (facebookUser) ->
    id:               uuid.createUuid()
    profiles:         {
      providerId:     facebookUser.uid
    }
    first:            facebookUser.first_name || ''
    last:             facebookUser.last_name || ''
    displayName:      facebookUser.displayName || facebookUser.username || ''
    name:             facebookUser.name || ''
    tagline:          ''
    bio:              ''
    image:            0
    favourites_count: 0
    followers_count:  0
    friends_count:    0
    emails:           ''
    url:              facebookUser.link          


  authenticateUser: (authUser, normalizeNewUser) ->
    self = @
    new Firebase App.FirebaseUri + '/profiles'
      .startAt(authUser.uid)
      .endAt(authUser.uid)
      .once 'value', (snapshot) ->
        console.log 'snapshot = ' + snapshot.getPriority()
        if snapshot.val()
          snapshot.forEach (user) ->
            # self.compareSnapshots(user.val().profile, authUser)
            memberRef = new Firebase App.FirebaseUri + '/members/' + user.val().memberId
            memberRef.once 'value', (snapshot) ->
              self.set('currentMember', snapshot.val())
        else
          self.createNewMember authUser, normalizeNewUser

  createNewMember: (user, normalizeNewUser) ->
    self = @
    newMember = normalizeNewUser user
    
    memberRef = new Firebase App.FirebaseUri + '/members/' + newMember.id
    profileRef = new Firebase App.FirebaseUri + '/profiles/'

    console.log 'priority before = ' + memberRef
    memberRef.setWithPriority newMember, newMember.displayName || newMember.name || '', (err) ->
      profileRef.push
        memberId:     newMember.id
        profile:      user
        '.priority':  user.uid
      
    self.set('currentMember', newMember)

  # compareSnapshots: (previousSnapshot, currentSnapshot) ->
  #   # ** todo - do a deep compare of the objects to find diffs
  #   workingset = Ember.ArrayProxy.create
  #     content: previousSnapshot

  #   console.log 'working set = ' + workingset
  #   null 



  updateProfile: (user, normalizeNewUser) ->
    user

  login: (provider) ->
    @authClient.login provider

  logout: ->
    @authClient.logout()

`export default authController`