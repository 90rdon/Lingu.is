sessionController = Ember.ObjectController.extend
  needs: [
    'member'
  ]

  memberRef: null

  init: ->
    self = @
    @set('store', App.__container__.lookup('store:main'))

  serialize: (memberRef, status) ->
    new Promise (resolve, reject) ->
      memberRef.buildFirebaseReference().once 'value', (snapshot) ->
        session = Ember.Object.create
          uuid:     snapshot.name()
          status:   status
          device:   'test'
          ip:       '0.0.0.0'
          meta:     'test'
          data:     'test'

        resolve(session)
      , (error) ->
        reject(error)

  persist: (session) ->
    self = @
    new Promise (resolve, reject) ->
      self.store.createRecord('session', session).save().then (sessionRef) ->
        resolve(sessionRef)
      , (error) ->
        reject(error)

  actions:  
    start: (memberRef) ->
      self = @
      @serialize(memberRef, 'started').then (session) ->
        self.persist(session).then (sessionRef) ->
          session = sessionRef.toFirebaseJSON()
          self.set('memberRef', memberRef)
          self.set('content', session)
          resolve(null)

    stop: ->
      self = @
      memberRef = @get('memberRef')
      @serialize(memberRef, 'stopped').then (session) ->
        self.persist(session).then (sessionRef) ->
          self.set('memberRef', memberRef)
          self.set('content', null)
          resolve(null)


`export default sessionController`