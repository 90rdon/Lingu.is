sessionController = Ember.ObjectController.extend
  init: ->
    @set('store', App.__container__.lookup('store:main'))

  create: (session) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.store.createRecord('session', session).save()
      .then (memberconnectionRef) ->
        resolve(memberconnectionRef)
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

  authorize: (memberRef, connectionRef) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      connectionRef.once 'value', (snapshot) ->
        self.serialize(
          connectionRef.name(),
          memberRef.buildFirebaseReference().name(),
          snapshot.val()
        ).then (session) ->
          self.store.fetch('session', session.id).then (existconnectionRef) ->
            resolve(existconnectionRef)
          , (notFound) ->
            session.set('logon', Firebase.ServerValue.TIMESTAMP)
            self.create(session).then (memberconnectionRef) ->
              memberconnectionRef.buildFirebaseReference()
              .child('logoff')
              .onDisconnect()
              .set(Firebase.ServerValue.TIMESTAMP)
              
              resolve(memberconnectionRef)

        , (error) ->
          reject(error)
      , (error) ->
        reject(error)

  last: (uuid) ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      
      self.store.fetch 'session', 
        endAt: uuid
        limit: 1

      .then (profiles) ->
        resolve(profiles)
      , (error) ->
        reject(error)

`export default sessionController`