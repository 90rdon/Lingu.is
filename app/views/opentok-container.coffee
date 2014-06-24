opentokContainer = Ember.View.extend
  didInsertElement: ->
    self = @
    apiKey = @get('controller').get('content').toFirebaseJSON().token.apiKey
    sessionId = @get('controller').get('content').toFirebaseJSON().token.ssessionId
    publisher = TB.initPublisher(apiKey, document.getByElementId('opentok'))
    session = TB.initSession(apiKey, seesionId)

    session.on streamCreated: (event) ->
      div = document.createElement('div')
      div.setAttribute 'id', 'stream' + event.stream.streamId
      document.body.appendChild div
      session.subscribe event.stream, div.id,
        subscribeToAudio: false

      return

    session.connect data.token, ->
      session.publish publisher
      return
    
`export default opentokContainer`