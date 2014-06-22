memberSessionController = Ember.ObjectController.extend
  init: ->
    self = @
    @set('store', App.__container__.lookup('store:main'))

  create: (session) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.createRecord('memberSession', session).save()
      .then (memberSessionRef) ->
        resolve(memberSessionRef)
      , (error) ->
        reject(error)

  serialize: (id, uuid, snapshot) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      reject()  unless snapshot

      session = Ember.Object.create
        id:       id
        uuid:     uuid
        device:   snapshot.device
        ip:       snapshot.ip
        meta:     snapshot.meta
        data:     snapshot.data
        on:       snapshot.on

      resolve(session)
    , (error) ->
      reject(error)

  authorize: (memberRef, sessionRef) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      sessionRef.once 'value', (snapshot) ->
        self.serialize(
          sessionRef.name(),
          memberRef.buildFirebaseReference().name(),
          snapshot.val()
        ).then (session) ->
          self.store.fetch('memberSession', session.id).then (existSessionRef) ->
            resolve(existSessionRef)
          , (notFound) ->
            session.set('logon', Firebase.ServerValue.TIMESTAMP)
            self.create(session).then (memberSessionRef) ->
              memberSessionRef.buildFirebaseReference()
              .child('logoff')
              .onDisconnect()
              .set(Firebase.ServerValue.TIMESTAMP)
              
              resolve(memberSessionRef)

        , (error) ->
          reject(error)
      , (error) ->
        reject(error)

  last: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      self.store.fetch 'memberSession', 
        endAt: uuid
        limit: 1

      .then (profiles) ->
        resolve(profiles)
      , (error) ->
        reject(error)

`export default memberSessionController`