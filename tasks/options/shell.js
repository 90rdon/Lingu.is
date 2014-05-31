module.exports = {
  prepare: {
    command: 'cordova prepare',
    options: {
      execOptions: {
        cwd: 'cordova/'
      },
      stderr: true,
      stdout: true
    }
  },
  serve: {
    command: 'cordova serve',
    options: {
      execOptions: {
        cwd: 'cordova/'
      },
      stderr: true,
      stdout: true
    }
  }
};
