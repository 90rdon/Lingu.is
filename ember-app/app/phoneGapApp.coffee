phoneGapApp = {
  # Application Constructor
  initialize: ->
    @bindEvents()
    # parentElement = document.getElementById('deviceready')
    # listeningElement = parentElement.querySelector('.listening')
    # receivedElement = parentElement.querySelector('.received')
    # listeningElement.setAttribute 'style', 'display:none;'
    # receivedElement.setAttribute 'style', 'display:block;'
  
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