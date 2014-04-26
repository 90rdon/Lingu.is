sessionController = Ember.Controller.extend
  init: ->
    self = @
    @set('store', App.__container__.lookup('store:main'))

  start: (memberRef) ->
    # sessionRef = @serialize(memberRef, 'started')
    # @persistSession(sessionRef)
    @persistSession(@serialize(memberRef, 'started'))

  serialize: (memberRef, status) ->
    # # key = record.attributeKeyFromName(attr)

    # sessionRef = @store.createRecord 'session',
    #   status:   status
    #   device:   'test'
    #   ip:       '0.0.0.0'
    #   meta:     'test'
    #   data:     'test'
      
    # uuid = memberRef.get('snapshot').name()
    # member = Ember.Object.create()
    # member.set(uuid, memberRef)
    # memberRef = sessionRef.buildFirebaseReference().child('member')
    # memberRef.set(member)
    # sessionRef
    #   # sessionRef.child(memberRef.attributeKeyFromName('member')).set(memberRef)

    session = Ember.Object.create
      status:   status
      device:   'test'
      ip:       '0.0.0.0'
      meta:     'test'
      data:     'test'
      members:  []

    session.get('members').addObject(memberRef)
    session


  persistSession: (session) ->
    self = @
    new Promise (resolve, reject) ->
      # sessionRef.save().then (sessionRef) ->
      #   resolve(sessionRef)
      # , (error) ->
      #   reject(error)
      self.store.createRecord('session', session).save().then (sessionRef) ->
        resolve(sessionRef)
      , (error) ->
        reject(error)

`export default sessionController`