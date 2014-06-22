sessionController = Ember.Controller.extend
  needs: [
    'history'
    'memberSession'
  ]

  status:       'online'
  onlineRef:      null
  thisSessionRef: null

  init: ->
    self = @
    @set('onlineRef',       new Firebase(App.firebaseUri + '/online'))
    @set('connectedRef',    new Firebase(App.firebaseUri + '/.info/connected'))
    @set('thisSessionRef',  @get('onlineRef').push(true))

    @get('connectedRef').on 'value', (isOnline) ->
      if isOnline.val()
        #on disconnect - remove this device
        self.get('thisSessionRef').onDisconnect().remove()
        self.create().then ->
          self.setMyStatus('online')
      else
        self.setMyStatus(self.get('status'))

  create: ->
    self = @
    new Ember.RSVP.Promise (resolve, reject) ->

      self.serialize().then (session) ->
        session.set('on', Firebase.ServerValue.TIMESTAMP)
        self.get('thisSessionRef').set(session)
        resolve()

  setMyStatus: (status) ->
    @set('status', status)
    @get('thisSessionRef').child('status').set(status)

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

`export default sessionController`