opentokContainer = Ember.View.extend
  didInsertElement: ->
    self = @
    apiKey = @get('controller').get('content').toFirebaseJSON().token.opentok
    sessionId = @get('controller').get('content').toFirebaseJSON().token.sessionId
    publisher = window.TB.initPublisher(apiKey, $('#opentok'))
    session = window.TB.initSession(apiKey, sessionId)

    session.on streamCreated: (event) ->
      div = document.createElement('div')
      div.setAttribute 'id', 'stream' + event.stream.streamId
      document.body.appendChild div
      session.subscribe event.stream, div.id,
        subscribeToAudio: false

      return

    session.connect @get('controller').get('content').toFirebaseJSON().token.token, ->
      session.publish publisher
      return
    
`export default opentokContainer`