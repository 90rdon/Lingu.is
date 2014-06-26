phoneGapApp = {
  # Application Constructor
  initialize: ->
    @bindEvents()
  
  # Bind Event Listeners
  #
  # Bind any events that are required on startup. Common events
  # are:
  # 'load', 'deviceready', 'offline', and 'connection'.
  bindEvents: ->
    document.addEventListener 'deviceready', @onDeviceReady, false
  
  # deviceready Event Handler
  #
  # The scope of 'this' is the event. In order to call the
  # 'receivedEvent'
  # function, we must explicity call 'app.receivedEvent(...);'
  onDeviceReady: ->
    console.log 'app from here? ' + App.serverUri
    phoneGapApp.receivedEvent 'deviceready'

    if parseFloat(window.device.version) is 7.0
      document.body.style.marginTop = '20px'

    # sessionConnectedHandler = (event) ->
    #   session.publish publisher
    #   subscribeToStreams event.streams

    # subscribeToStreams = (streams) ->
    #   i = 0

    #   while i < streams.length
    #     stream = streams[i]
    #     session.subscribe stream  unless stream.connection.connectionId is session.connection.connectionId
    #     i++

    # streamCreatedHandler = (event) ->
    #   subscribeToStreams event.streams

    # publisher = TB.initPublisher(apiKey)
    # session = TB.initSession(sessionId)
    # session.connect apiKey, token

    # session.addEventListener 'sessionConnected', sessionConnectedHandler
    # session.addEventListener 'streamCreated', streamCreatedHandler

    console.log 'PhoneGap binded'
    
  # Update DOM on a Received Event
  receivedEvent: (id) ->
    # console.log 'PhoneGap binding to device uuid = ' + window.device.uuid
    # parentElement = document.getElementById(id)
    # listeningElement = parentElement.querySelector('.listening')
    # receivedElement = parentElement.querySelector('.received')
    # listeningElement.setAttribute 'style', 'display:none;'
    # receivedElement.setAttribute 'style', 'display:block;'
    
    console.log 'Received Event: ' + id
}

`export default phoneGapApp`