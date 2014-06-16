# Firebase Simple Login Hook

authenticationController = Ember.Controller.extend
  needs: [
    'session'
    'profile'
    'member'
    'session'
  ]

  memberId: null

  allowed: (->
    return true if @get('controllers.session.content')
    false
  ).property('controllers.session.content')

  init: ->
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
  
          # --- hand out session after authentication
          self.authorize(memberRef)

          
      # --- default ---
      else
        return

    ).bind(@))

  # --- find the member ---

  # --- authenticating to our app now ---
  authenticate: (identity) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profile').findAll(identity.uid).then (profiles) ->

        if profiles.get('length') is 0
          # New Member
          self.get('controllers.member').createMember(identity).then (memberRef) ->
            resolve(memberRef)
        else
          # Existing Member
          profile = profiles.get('lastObject').toFirebaseJSON()
          self.get('controllers.member').findRefByUuid(profile.uuid).then (memberRef) ->
            resolve(memberRef)
      , (error) ->
        reject(error)

  authorize: (memberRef) ->
    @get('controllers.session').send('authorize', memberRef)
    @set('memberId', memberRef.buildFirebaseReference().name())
    
  invalidate: ->
    @authClient.logout()
    @get('controllers.session').send('invalidate')
    @set('memberId', null)

  actions:
    login: (provider) ->
      @authClient.login provider

    logout: ->
      @invalidate()

`export default authenticationController`