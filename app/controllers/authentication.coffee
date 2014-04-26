`import UUID              from 'linguis/utils/auth/uuid'`
`import NormalizeAccount  from 'linguis/utils/auth/normalize-account'`

authenticationController = Ember.Controller.extend
  needs: [
    'session'
  ]

  session: null

  init: ->
    @_super()
    self = @
    @set('store', App.__container__.lookup('store:main'))

    # create a new firebase login instance
    dbRef = new Firebase App.firebaseUri
    @authClient = new FirebaseSimpleLogin(dbRef, ((error, identity) ->
      # --- error ---
      if error
        self.invalidate()

      # --- authenticated with firebase ---
      else if identity
        # --- authenticating to our app now ---
        self.authenticate(identity).then (memberRef) ->
  
          # --- give out session after authentication
          self.authorize(memberRef)
          
      # --- default ---
      else
        self.invalidate()

    ).bind(@))

  # --- authenticating to our app now ---
  authenticate: (identity) ->
    self = @
    new Promise (resolve, reject) ->

      # Find the profile by uid
      self.store.fetch 'profile', 
        startAt:  identity.uid
        endAt:    identity.uid
      .then (profiles) ->

        if profiles.get('length') is 0

          # New Member
          self.createMember(identity).then (memberRef) ->
            resolve(memberRef)
        else

          # Existing Member
          profile = profiles.get('lastObject').toFirebaseJSON()
          self.store.fetch('member',  profile.uuid).then (memberRef) ->
            resolve(memberRef)

      # Error
      , (error) ->
        # self.createMember(identity).then (member) ->
        #   resolve(member.toFirebaseJSON())
        reject(error)

  authorize: (memberRef) ->
    self = @
    @get('controllers.session').start(memberRef).then (sessionRef) ->
      self.set('session', sessionRef.toFirebaseJSON())

  invalidate: ->
    @set('session', null)


  login: (provider) ->
    @authClient.login provider

  logout: ->
    @authClient.logout()

  
  # createProfile: (identity) ->
  #   self = @
  #   new Promise (resolve) ->

  #     uuid = UUID.createUuid()
  #     self.store.createRecord 'profile',
  #       identity:     identity
  #       uid:          identity.uid
  #       uuid:         uuid
  #       provider:     identity.provider
  #     .save().then (profileRef) ->
  #       resolve(profileRef)
      
  normalize: (profile) ->
    new Promise (resolve) ->

      switch profile.toFirebaseJSON().provider
        when 'twitter'  then resolve(NormalizeAccount.Twitter(profile))
        when 'github'   then resolve(NormalizeAccount.Github(profile))
        when 'twitter'  then resolve(NormalizeAccount.Facebook(profile))

  createMember: (identity) ->
    self = @
    new Promise (resolve, reject) ->

      self.store.createRecord 'profile',
        identity:     identity
        uid:          identity.uid
        uuid:         UUID.createUuid()
        provider:     identity.provider
      .save().then (profileRef) ->
        self.normalize(profileRef).then (user) ->
          self.store.createRecord('member', user).save().then (memberRef) ->
            resolve(memberRef)
          , (error) ->
            reject(error)

`export default authenticationController`