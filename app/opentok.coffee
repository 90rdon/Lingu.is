apiKey    = '44669212'
sessionId = '1_MX4yMjgyODI0Mn5-RnJpIEZlYiAyOCAwOTo1NToyOSBQU1QgMjAxNH4wLjM5Mjg1MTM1fg'
token     = 'T1==cGFydG5lcl9pZD0yMjgyODI0MiZzZGtfdmVyc2lvbj10YnJ1YnktdGJyYi12MC45MS4yMDExLTAyLTE3JnNpZz0wNWJiNDIyOTAyNzA5ZGY0YzAwZmUyNGQwMjY1NGM3MzNlYjIxMGFhOnJvbGU9cHVibGlzaGVyJnNlc3Npb25faWQ9MV9NWDR5TWpneU9ESTBNbjUtUm5KcElFWmxZaUF5T0NBd09UbzFOVG95T1NCUVUxUWdNakF4Tkg0d0xqTTVNamcxTVRNMWZnJmNyZWF0ZV90aW1lPTEzOTM2MTAxNDcmbm9uY2U9MC4wMzA4OTg2NjI1MjUzNzY4NzQmZXhwaXJlX3RpbWU9MTM5NDIxNDk0NyZjb25uZWN0aW9uX2RhdGE9'

opentok = {
  init: ->
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
}

`export default opentok`