sessionsContainer = Ember.View.extend
  # Use idle/away/back events created by idle.js to update our status information.
  didInsertElement: ->
    self = @
    document.onIdle = ->
      self.get('controller').get('controllers.connection').setMyStatus('idle')
    document.onAway = ->
      self.get('controller').get('controllers.connection').setMyStatus('away')
    document.onBack = (isIdle, isAway)->
      self.get('controller').get('controllers.connection').setMyStatus('online')

    setIdleTimeout(5000)
    setAwayTimeout(10000)
    
`export default sessionsContainer`