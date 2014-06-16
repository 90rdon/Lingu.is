sessionsController = Ember.Controller.extend
  status: 'online'
  sessionsRef: null
  meRef: null
  connected: null

  init: ->
    self = @
    # @set('store', App.__container__.lookup('store:main'))
    @set('sessionsRef', new Firebase(App.firebaseUri + '/sessions'))
    # add me to sessions list
    @set('meRef', @get('sessionsRef').push(true))
    @set('connectedRef', new Firebase(App.firebaseUri + '/.info/connected'))

    # lastOnlineRef = new Firebase(App.firebaseUri + '/sessions/lastOnline')

    @get('connectedRef').on 'value', (isOnline) ->
      
      if isOnline.val()
        #on disconnect - remove this device
        self.get('meRef').onDisconnect().remove()

        # add last time was online
        # lastOnline.onDisconnect().set(Firebase.ServerValue.TIMESTAMP)

        # set
        self.setMyStatus('online')
      else
        self.setMyStatus(self.get('status'))

  setMyStatus: (status) ->
    self = @
    @set('status', status)
    @serialize().then (session) ->
      self.get('meRef').set(session)

  serialize: ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->
      session = Ember.Object.create
        status:   self.get('status')
        device:   'test'
        ip:       '0.0.0.0'
        meta:     'test'
        data:     'test'

      resolve(session)
    , (error) ->
      reject(error)

  # persist: (session) ->
  #   self = @
  #   new Ember.RSVP.Promise (resolve, reject) ->
  #     self.store.createRecord('sessions', session).save().then (sessionRef) ->
  #       session = sessionRef.toFirebaseJSON()
  #       resolve(session)
  #     , (error) ->
  #       reject(error)


`export default sessionsController`