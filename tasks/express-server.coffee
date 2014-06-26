module.exports = (grunt) ->
  
  ###
  Task for serving the static files.
  
  Note: The expressServer:debug task looks for files in multiple directories.
  ###
  
  # Load namespace module before creating the server
  
  # Load API stub routes
  
  # Use API proxy
  
  # For `expressServer:debug`
  
  # Add livereload middleware after lock middleware if enabled
  
  # These three lines simulate what the `copy:assemble` task does
  # For test-helper.js and test-loader.js
  # Gotta catch \'em all
  
  # For `expressServer:dist`
  # Gotta catch \'em all
  
  # Middleware
  # ==========
  lock = (req, res, next) -> # Works with tasks/locking.js
    (retry = ->
      if lockFile.checkSync('tmp/connect.lock')
        setTimeout retry, 30
      else
        next()
    )()

  static_ = (options) ->
    (req, res, next) -> # Gotta catch \'em all (and serve index.html)
      filePath = ''
      if options.directory
        regex = new RegExp('^' + (options.urlRoot or ''))
        
        # URL must begin with urlRoot\'s value
        unless req.path.match(regex)
          next()
          return
        filePath = options.directory + req.path.replace(regex, '')
      else if options.file
        filePath = options.file
      else
        throw new Error('static() isn\'t properly configured!')
      fs.stat filePath, (err, stats) ->
        if err # Not a file, not a folder => can\'t handle it
          next()
          return
        if options.ignoredFileExtensions
          if options.ignoredFileExtensions.test(req.path)
            res.send 404,
              error: 'Resource not found'

            return # Do not serve index.html
        
        # Is it a directory? If so, search for an index.html in it.
        filePath = path.join(filePath, 'index.html')  if stats.isDirectory()
        
        # Serve the file
        res.sendfile filePath, (err) ->
          if err
            next()
            return
          grunt.verbose.ok 'Served: ' + filePath


  passThrough   = (target) ->
    (req, res) ->
      req.pipe(request(target + req.url)).pipe res

  
  OpenTok       = require('opentok')
  express       = require('express')
  lockFile      = require('lockfile')
  Helpers       = require('./helpers')
  fs            = require('fs')
  path          = require('path')
  request       = require('request')
  Firebase      = require('firebase')


  grunt.registerTask 'expressServer', (target, keepalive) ->
    require 'express-namespace'
    
    app = express()
    done = @async()
    # proxyMethod = proxyMethodToUse or grunt.config('express-server.options.APIMethod')
    proxyMethod = grunt.config('express-server.options.APIMethod')
    app.use lock
    app.use express.compress()
    app.use app.router


    if proxyMethod is 'stub'
      grunt.log.writeln 'Using API Stub'
      app.use express.json()
      app.use express.urlencoded()
      require('../api-stub/routes') app
    else if proxyMethod is 'proxy'
      proxyURL = grunt.config('express-server.options.proxyURL')
      proxyPath = grunt.config('express-server.options.proxyPath') or '/api'
      grunt.log.writeln 'Proxying API requests matching ' + proxyPath + '/* to: ' + proxyURL
      app.all proxyPath + '/*', passThrough(proxyURL)

    if target is 'debug'
      app.use require('connect-livereload')()  if Helpers.isPackageAvailable('connect-livereload')
      app.use express.errorHandler ( 
        dumpExceptions: true
        showStack: true 
      )
      app.use static_(
        urlRoot: '/config'
        directory: 'config'
      )
      app.use static_(
        urlRoot: '/lib'
        directory: 'lib'
      )
      app.use static_(
        urlRoot: '/vendor'
        directory: 'vendor'
      )
      app.use static_(directory: 'public')
      app.use static_(
        urlRoot: '/tests'
        directory: 'tests'
      )
      app.use static_(directory: 'tmp/result')
      app.use static_(
        file: 'tmp/result/index.html'
        ignoredFileExtensions: /\.\w{1,5}$/
      )
    else
      app.use lock
      app.use static_(directory: 'dist')
      app.use static_(
        file: 'dist/index.html'
        ignoredFileExtensions: /\.\w{1,5}$/
      )


    # --- initialize opentok ---
    urlSessions   = {};
    OTKEY         = process.env.TB_KEY || grunt.config('opentok|| .options.tokboxKey')
    OTSECRET      = process.env.TB_SECRET grunt.config('opentok.options.tokboxSecret')
    opentok       = new OpenTok(OTKEY, OTSECRET)

    sendResponse  = (sessionKey, sessionId, res) ->
      token       = opentok.generateToken(sessionId)
      data        = opentok: OTKEY, sessionId: sessionId, token: token

      firebaseUri = process.env.FB_URI || grunt.config('firebase.options.uri')
      callRef     = new Firebase(firebaseUri + 'call')
      callRef.child(sessionKey).set(token: data)
      res.send 200

    # to debug, use http://0.0.0.0:8080/token/123
    app.get '/token/:session_id', (req, res) ->
      return res.status(500).send(err: 'Session Id required.')  unless req.params.session_id?

      # todo: add to check if this session id is validate from firebase 
      
      unless urlSessions[ req.params.session_id ]?
        opentok.createSession (err, session) ->
          return res.send 500, err: err  if err
          urlSessions[ req.params.session_id ] = session.sessionId
          sendResponse req.params.session_id, session.sessionId, res
      else
        sendResponse req.params.session_id, urlSessions[ req.params.session_id ], res


    port = parseInt(process.env.PORT or 3333, 10)

    grunt.fail.fatal 'The PORT environment variable of ' + process.env.PORT + ' is not valid.'  if isNaN(port) or port < 1 or port > 65535
    app.listen port
    grunt.log.ok 'Started development server on port %d.', port

    done()  unless keepalive