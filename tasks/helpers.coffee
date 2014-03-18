grunt = require('grunt')
_ = grunt.util._
Helpers = {}

# List of package requisits for tasks
# Notated in conjunctive normal form (CNF)
# e.g. ['a', ['b', 'alternative-to-b']]
taskRequirements =
  coffee: ['grunt-contrib-coffee']
  compass: ['grunt-contrib-compass']
  sass: [[
    'grunt-sass'
    'grunt-contrib-sass'
  ]]
  less: ['grunt-contrib-less']
  stylus: ['grunt-contrib-stylus']
  emberTemplates: ['grunt-ember-templates']
  emblem: ['grunt-emblem']
  emberscript: ['grunt-ember-script']
  imagemin: ['grunt-contrib-imagemin']
  htmlmin: ['grunt-contrib-htmlmin']
  fancySprites: ['grunt-fancy-sprites']
  autoprefixer: ['grunt-autoprefixer']
  rev: ['grunt-rev']


# Task fallbacks
# e.g. 'a': ['fallback-a-step-1', 'fallback-a-step-2']
taskFallbacks = imagemin: 'copy:imageminFallback'

Helpers.filterAvailableTasks = (tasks) ->
  tasks = tasks.map((taskName) ->
    
    # Maps to task name or fallback if task is unavailable
    baseName = taskName.split(':')[0] # e.g. 'coffee' for 'coffee:compile'
    reqs = taskRequirements[baseName]
    isAvailable = Helpers.isPackageAvailable(reqs)
    (if isAvailable then taskName else taskFallbacks[taskName])
  )
  _.flatten _.compact(tasks) # Remove undefined's and flatten it

Helpers.isPackageAvailable = (pkgNames) ->
  return true  unless pkgNames # packages are assumed to exist
  pkgNames = [pkgNames]  unless _.isArray(pkgNames)
  _.every pkgNames, (pkgNames) ->
    pkgNames = [pkgNames]  unless _.isArray(pkgNames)
    _.any pkgNames, (pkgName) ->
      !!Helpers.pkg.devDependencies[pkgName]



module.exports = Helpers