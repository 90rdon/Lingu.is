`import UUID  from 'linguis/utils/auth/uuid'`

profileController = Ember.ObjectController.extend
  init: ->
    self = @
    @set('store', App.__container__.lookup('store:main'))

  createProfile: (identity) ->
    self = @
    new Promise (resolve, reject) ->

      self.store.createRecord 'profile',
        identity:     identity.thirdPartyUserData
        uid:          identity.uid
        uuid:         UUID.createUuid()
        provider:     identity.provider

      .save().then (profileRef) ->
        resolve(profileRef)
      , (error) ->
        reject(error)

  findAll: (uid) ->
    self = @
    new Promise (resolve, reject) ->
      
      self.store.fetch 'profile', 
        startAt:  uid
        endAt:    uid

      .then (profiles) ->
        resolve(profiles)
      , (error) ->
        reject(error)

`export default profileController`