apiKey    = '44669212'
sessionId = '1_MX40NDY2OTIxMn5-V2VkIEZlYiAyNiAxNDoxMzoyOSBQU1QgMjAxNH4wLjE4MDE2ODY5fg'
token     = 'T1==cGFydG5lcl9pZD00NDY2OTIxMiZzZGtfdmVyc2lvbj10YnJ1YnktdGJyYi12MC45MS4yMDExLTAyLTE3JnNpZz02NDkxNGRjYzlhNTJiN2E2MmVhNmU4ZmQ5M2UwM2EyY2RjYzJkYmNkOnJvbGU9c3Vic2NyaWJlciZzZXNzaW9uX2lkPTFfTVg0ME5EWTJPVEl4TW41LVYyVmtJRVpsWWlBeU5pQXhORG94TXpveU9TQlFVMVFnTWpBeE5INHdMakU0TURFMk9EWTVmZyZjcmVhdGVfdGltZT0xMzkzNDUzMzE5Jm5vbmNlPTAuMzcyMDI1NzMwMzg1NzE3MiZleHBpcmVfdGltZT0xMzk2MDQ0ODAzJmNvbm5lY3Rpb25fZGF0YT0='

phoneGapApp = {
  # Application Constructor
  initialize: ->
    @bindEvents()
  
  # Bind Event Listeners
  #
  # Bind any events that are required on startup. Common events
  # are:
  # 'load', 'deviceready', 'offline', and 'online'.
  bindEvents: ->
    document.addEventListener 'deviceready', @onDeviceReady, false
  
  # deviceready Event Handler
  #
  # The scope of 'this' is the event. In order to call the
  # 'receivedEvent'
  # function, we must explicity call 'app.receivedEvent(...);'
  onDeviceReady: ->
    console.log 'PhoneGap binding...'
    phoneGapApp.receivedEvent 'deviceready'

    sessionConnectedHandler = (event) ->
      session.publish publisher
      subscribeToStreams event.streams

    subscribeToStreams = (streams) ->
      i = 0

      while i < streams.length
        stream = streams[i]
        session.subscribe stream  unless stream.connection.connectionId is session.connection.connectionId
        i++

    streamCreatedHandler = (event) ->
      subscribeToStreams event.streams

    publisher = TB.initPublisher(apiKey)
    session = TB.initSession(sessionId)
    session.connect apiKey, token

    session.addEventListener 'sessionConnected', sessionConnectedHandler
    session.addEventListener 'streamCreated', streamCreatedHandler

    console.log 'PhoneGap binded'
    
  # Update DOM on a Received Event
  receivedEvent: (id) ->
    parentElement = document.getElementById(id)
    listeningElement = parentElement.querySelector('.listening')
    receivedElement = parentElement.querySelector('.received')
    listeningElement.setAttribute 'style', 'display:none;'
    receivedElement.setAttribute 'style', 'display:block;'
    
    console.log 'Received Event: ' + id
}

`export default phoneGapApp`