`import normalizeAccount  from 'linguis/utils/auth/normalize-account'`

firebaseAuthenticatorController = Ember.Controller.extend
  needs: [
    'firebase-session'
    'firebase-member'
    'firebase-profile'
  ]

  session: null

  authenticated: (->
    true if session
    false
  ).property()

  init: ->
    self = @
    dbRef = new Firebase App.firebaseUri
    @authClient = new FirebaseSimpleLogin(dbRef, ((error, identity) ->
      # --- error ---
      if error
        self.invalidate()

      # --- authenticated with firebase ---
      else if identity
        # --- authenticating to our app now ---
        self.authenticate(identity).then (member) ->
  
          # --- give out session after authentication
          self.authorize(member) if member
          
      # --- default ---
      else
        self.invalidate()

    ).bind(@))

  # --- authenticating to our app now ---
  authenticate: (identity) ->
    self = @
    new Promise (resolve, reject) ->
      self.get('controllers.firebase-profile').findByUID(identity.uid).then (profile) ->
        # Exising Member
        if profile
          member = self.get('controllers.firebase-member').find(member.val().memberId)
          resolve(member)

        # New Member
        else
          switch identity.provider
            when 'twitter'  then user = normalizeAccount.Twitter
            when 'github'   then user = normalizeAccount.Github
            when 'twitter'  then user = normalizeAccount.Facebook

          self.get('controllers.firebase-member').create(user).then (member) ->
            self.get('controller.firebase-profile').create(member, identity).then (profile) ->
              resolve(member)

    
  authorize: (member) ->
    @get('controllers.firebase-session').startSession(member).then (session) ->
      @set('session', session)

  invalidate: ->
    @set('session', null)

  login: (provider) ->
    @authClient.login provider

  logout: ->
    @authClient.logout()

`export default firebaseAuthenticatorController`