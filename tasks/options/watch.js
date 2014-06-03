var Helpers = require('../helpers'),
    filterAvailable = Helpers.filterAvailableTasks,
    liveReloadPort = parseInt(process.env.PORT || 8000, 10) + 2;

var server = [
      'server/**/*.{js,coffee}'
    ],
    scripts = [
      '{app,tests,config}/**/*.{js,coffee,em}'
    ],
    templates = 'app/templates/**/*.{hbs,handlebars,hjs,emblem}',
    sprites = 'app/sprites/**/*.{png,jpg,jpeg}',
    styles = 'app/styles/**/*.{css,sass,scss,less,styl}',
    indexHTML = 'app/index.html',
    other = '{app,tests,public}/**/*',
    bowerFile = 'bower.json',
    npmFile = 'package.json';

module.exports = {
  // express: {
  //   files:  [server],
  //   tasks:  [ 'lock', 'expressServer:debug', 'unlock' ],
  //   options: {
  //     spawn: false // for grunt-contrib-watch v0.5.0+, "nospawn: true" for lower versions. Without this option specified express won't be reloaded
  //   }
  // },
  scripts: {
    files: [scripts],
    tasks: ['lock', 'buildScripts', 'copy:cordovaDebug', 'shell:prepare', 'unlock']
  },
  templates: {
    files: [templates],
    tasks: ['lock', 'buildTemplates:debug', 'copy:cordovaDebug', 'shell:prepare', 'unlock']
  },
  sprites: {
    files: [sprites],
    tasks: filterAvailable(['lock', 'fancySprites:create', 'copy:cordovaDebug', 'shell:prepare', 'unlock'])
  },
  styles: {
    files: [styles],
    tasks: ['lock', 'buildStyles', 'copy:cordovaDebug', 'shell:prepare', 'unlock']
  },
  indexHTML: {
    files: [indexHTML],
    tasks: ['lock', 'buildIndexHTML:debug', 'copy:cordovaDebug', 'shell:prepare', 'unlock']
  },
  other: {
    files: [other, '!'+scripts, '!'+templates, '!'+styles, '!'+indexHTML, bowerFile, npmFile],
    tasks: ['lock', 'build:debug', 'copy:cordovaDebug', 'shell:prepare', 'unlock']
  },

  options: {
    // No need to debounce
    debounceDelay: 0,
    // When we don't have inotify
    interval: 100,
    livereload: Helpers.isPackageAvailable("connect-livereload") || liveReloadPort
  }
};
