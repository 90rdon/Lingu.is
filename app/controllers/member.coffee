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

  createMember: (identity) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.get('controllers.profile').createProfile(identity).then (profileRef) ->
        self.normalize(profileRef).then (user) ->
          user.set('id', profileRef.toFirebaseJSON().uuid)
          self.store.createRecord('member', user).save().then (memberRef) ->
            resolve(memberRef)
          , (error) ->
            reject(error)

  findRefByUuid: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      self.store.fetch('member',  uuid).then (memberRef) ->
        resolve(memberRef)
      , (error) ->
        reject(error)

`export default memberController`