# Firebase Simple Login Hook
authenticationController = Ember.Controller.extend
  needs: [
    'connection'
    'profile'
    'profiles'
    'member'
    'session'
  ]

  memberRef:        null
  sessionRef:       null

  statusChange: (->
    return  unless @get('sessionRef')
    @get('controllers.member')
    .refresh(@get('memberRef'), @get('controllers.connection').get('status'))
  ).observes('controllers.connection.status')

  init: ->
    self = @
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
          self.set('memberRef', memberRef)
          # --- hand out session after authentication
          self.authorize(memberRef).then (sessionRef) ->
            self.set('sessionRef', sessionRef)

      # --- default ---
      else
        console.log 'default happened'

    ).bind(@))

  # --- authenticating to our app now ---
  authenticate: (identity) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profiles').findAll(identity.uid).then (profiles) ->
        if profiles.get('length') is 0
          # New Member
          self.get('controllers.member').create(identity).then (memberRef) ->
            resolve(memberRef)
        else
          # Existing Member
          profile = profiles.get('lastObject').toFirebaseJSON()
          self.get('controllers.member').findRefByUuid(profile.uuid).then (memberRef) ->
            resolve(memberRef)
          , (notFound) ->
            self.get('controllers.member').create(identity).then (memberRef) ->
              resolve(memberRef)

      , (error) ->
        reject(error)

  authorize: (memberRef) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.member')
      .logon(memberRef, true)

      self.get('controllers.member')
      .refresh(memberRef, self.get('controllers.connection').get('status'))
      
      self.get('controllers.session')
      .authorize(memberRef, self.get('controllers.connection').get('thisConnectionRef'))
      .then (sessionRef) ->
        resolve(sessionRef)
      , (error) ->
        reject(error)

  invalidate: ->
    @authClient.logout()

    @get('controllers.member')
    .logon(@get('memberRef'), false)

    @get('controllers.member')
    .refresh(@get('memberRef'), 'logoff')

    @set('sessionRef', null)

  actions:
    login: (provider) ->
      @authClient.login provider

    logout: ->
      @invalidate()

`export default authenticationController`