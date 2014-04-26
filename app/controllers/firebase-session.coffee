firebaseSessionController = Ember.Controller.extend
  init: ->
    @sessionRef = new Firebase App.firebaseUri + '/session'

  startSession: (member) ->
    @persistSession
      event: 'start'
      timestamp: Firebase.ServerValue.TIMESTAMP
      memberId: member.id
      device: 'test'
      ip: '0.0.0.0'
      meta: 'test'
      data: 'test'
      identity: member

  endSession: ->
    session = @get('content')
    @persistSession
      event: 'end'
      timestamp: Firebase.ServerValue.TIMESTAMP
      memberId: session.memberId
      device: 'test'
      ip: '0.0.0.0'
      meta: 'test'
      data: 'test'
      identity: session.identity

  persistSession: (session) ->
    self = @
    new Promise (resolve, reject) ->
      reject(error: 'undefined session') if not session      
      resolve @sessionRef.push session

`export default firebaseSessionController`