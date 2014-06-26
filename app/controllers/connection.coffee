`import UUID  from 'linguis/utils/auth/uuid'`

connectionController = Ember.Controller.extend
  needs: [
    'session'
    'token'
  ]

  status:           'online'
  connectionRef:      null
  thisConnectionRef:  null

  init: ->
    self = @
    @set('connectionRef',   new Firebase(App.firebaseUri + '/connection'))
    @set('connectedRef',    new Firebase(App.firebaseUri + '/.info/connected'))
    @set('thisConnectionRef',   @get('connectionRef').push(true))

    @get('connectedRef').on 'value', (isconnection) ->
      if isconnection.val()
        #on disconnect - remove this device
        self.get('thisConnectionRef').onDisconnect().remove()
        self.create().then ->
          self.setMyStatus('online')
      else
        self.setMyStatus(self.get('status'))

  create: ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.serialize().then (session) ->
        session.set('on', Firebase.ServerValue.TIMESTAMP)
        self.get('thisConnectionRef').set(session)
        resolve()

  setMyStatus: (status) ->
    @set('status', status)
    @get('thisConnectionRef').child('status').set(status)

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

  actions:
    call: ->
      @transitionToRoute 'call', UUID.createShortUrl()


`export default connectionController`