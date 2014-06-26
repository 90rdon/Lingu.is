`import NormalizeAccount  from 'linguis/utils/auth/normalize-account'`

memberController = Ember.ObjectController.extend
  needs: [
    'profile'
  ]

  init: ->
    self = @
    @set('store', App.__container__.lookup('store:main'))

  normalize: (profileRef) ->
    new Ember.RSVP.Promise (resolve) ->

      switch profileRef.toFirebaseJSON().provider
        when 'twitter'    then resolve(NormalizeAccount.Twitter(profileRef))
        when 'github'     then resolve(NormalizeAccount.Github(profileRef))
        when 'facebook'   then resolve(NormalizeAccount.Facebook(profileRef))

  create: (identity) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profile').create(identity).then (profileRef) ->
        self.normalize(profileRef).then (user) ->
          user.set('id', profileRef.toFirebaseJSON().uuid)
          self.store.createRecord('member', user).save().then (memberRef) ->
            resolve(memberRef)
          , (error) ->
            reject(error)

  logon: (memberRef, logon) ->
    memberRef.buildFirebaseReference()
    .child('logon')
    .set(logon)

    memberRef.buildFirebaseReference()
    .child('logon')
    .onDisconnect()
    .set(false)

    memberRef.buildFirebaseReference()
    .child('status')
    .onDisconnect()
    .set('logoff')

  refresh: (memberRef, status) ->
    memberRef.buildFirebaseReference()
    .child('status')
    .set(status)

  findRefByUuid: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.fetch('member',  uuid).then (memberRef) ->
        resolve(memberRef)
      , (error) ->
        reject(error)


`export default memberController`