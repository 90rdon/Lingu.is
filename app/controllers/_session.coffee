# Firebase Simple Login Hook

sessionController = Ember.ObjectController.extend
  needs: [
    'member'
  ]

  connectedRef: null

  init: ->
    @_super()
    @set('store', App.__container__.lookup('store:main'))

  serialize: (uuid, status) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      session = Ember.Object.create
        uuid:     uuid
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
    new Ember.RSVP.Promise (resolve, reject) ->
      self.store.createRecord('session', session).save().then (sessionRef) ->
        session = sessionRef.toFirebaseJSON()
        resolve(session)
      , (error) ->
        reject(error)

  findAllByUuid: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      self.store.fetch('session',
        startAt:  uuid
        endAt:    uuid
      ).then (sessionsRef) ->
        resolve(sessionsRef)
      , (error) ->
        reject(error)

  actions:  
    authorize: (memberRef) ->
      self = @
      @findAllByUuid(memberRef.buildFirebaseReference().name()).then (sessionsRef) ->
        if sessionsRef.get('length') > 0
          session = sessionsRef.get('lastObject').toFirebaseJSON()
          self.set('content', session)
        else
          self.serialize(memberRef.buildFirebaseReference().name(), 'started').then (session) ->
            self.persist(session).then (session) ->
              self.set('content', session)

    invalidate: ->
      return  unless @get('content')
      self = @
      @serialize(@get('content.uuid'), 'stopped').then (session) ->
        self.persist(session).then (session) ->
          self.set('content', null)


`export default sessionController`