authenticationController = Ember.Controller.extend
  needs: [
    'session'
    'profile'
    'member'
  ]

  allowed: (->
    @get('controllers.session.content')?
  ).property('controllers.session.content')

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

  # --- find the member ---

  # --- authenticating to our app now ---
  authenticate: (identity) ->
    self = @
    new Promise (resolve, reject) ->

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
    @get('controllers.session').send('start', memberRef)
    
  invalidate: ->
    self = @
    @get('controllers.session').send('stop').then ->
      self.authClient.logout()

  actions:
    login: (provider) ->
      @authClient.login provider

    logout: ->
      @invalidate()

`export default authenticationController`