`import uuid from 'linguis/utils/uuid'`

authController = Ember.Controller.extend
  needs: [
    'member'
  ]

  currentMember: null
  allowed: false
  session: null

  authChange: (->
    if @get('currentMember') then @set('allowed', true) else @set('allowed', false)
  ).observes('currentMember')

  init: ->
    self = @
    dbRef = new Firebase App.FirebaseUri
    @authClient = new FirebaseSimpleLogin(dbRef, ((error, identity) ->
      # --- error ---
      if error
        self.set('currentMember', null)

      # --- authenticate ---
      else if identity
        switch identity.provider
          when 'twitter' then self.authenticateUser identity, self.normalizeTwitterUser
          when 'github' then self.authenticateUser identity, self.normalizeGithubUser
          when 'facebook' then self.authenticateUser identity, self.normalizeFacebookUser
          
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
    name:             githubUser.name || githubUser.username
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


  authenticateUser: (identity, normalizeNewUser) ->
    self = @

    # tasks to run before finalizing authtentication
    finalize = (member) ->
      self.set('currentMember', member)
      self.createSession(identity, member)

    new Firebase App.FirebaseUri + '/profiles'
      .startAt(identity.uid)    
      .endAt(identity.uid)
      .once 'value', (snapshot) ->
        if snapshot.val()
          snapshot.forEach (user) ->
            # self.compareSnapshots(user.val().profile, identity)
            memberRef = new Firebase App.FirebaseUri + '/members/' + user.val().memberId
            memberRef.once 'value', (snapshot) ->
              finalize(snapshot.val())
        else
          self.createNewMember(identity, normalizeNewUser).then (newMember) ->
            finalize(newMember)

  createNewMember: (user, normalizeNewUser) ->
    new Promise (resolve, reject) ->
      self = @
      newMember = normalizeNewUser user
      
      memberRef = new Firebase App.FirebaseUri + '/members/' + newMember.id
      profileRef = new Firebase App.FirebaseUri + '/profiles/'

      memberRef.setWithPriority newMember, newMember.displayName || newMember.name || '', (err) ->
        reject err      if err
        profileRef.push
          memberId:     newMember.id
          profile:      user
          '.priority':  user.uid

        resolve newMember
      
  # compareSnapshots: (previousSnapshot, currentSnapshot) ->
  #   # ** todo - do a deep compare of the objects to find diffs
  #   workingset = Ember.ArrayProxy.create
  #     content: previousSnapshot

  #   console.log 'working set = ' + workingset
  #   null 


  updateProfile: (user, normalizeNewUser) ->
    user

  createSession: (identity, member) ->

    sessionRef = new Firebase App.FirebaseUri + '/session'
    sessionRef.push
      event: 'login'
      timestamp: Firebase.ServerValue.TIMESTAMP
      memberId: member.id
      device: 'test'
      ip: '0.0.0.0'
      meta: 'test'
      data: 'test'

    @set('session', sessionRef)

  login: (provider) ->
    @authClient.login provider

  logout: ->
    @authClient.logout()

`export default authController`