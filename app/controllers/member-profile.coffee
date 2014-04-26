memberProfileController = Ember.Controller.extend
  # store: null

  # init: ->
  #   @set('store', App.__container__.lookup('store:main'))

  create: (user) ->
    self = @
    Ember.run ->
      self.store.createRecord('member', user).save().then (member) ->
        if member
          # Ember.run ->
          #   profile = 
          #     memberId:     member.id
          #     identity:     identity
          #     '.priority':  identity.uid
          #   self.get('store').createRecord('profile', profile).save()

          resolve(member)
        else
          reject(error: 'Cannot create member')
      , (error) ->
        reject(error: error)

`export default memberProfileController`