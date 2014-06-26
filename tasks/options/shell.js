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
  },
  emulateIOS: {
    command: 'cordova emulate ios',
    options: {
      execOptions: {
        cwd: 'cordova/'
      },
      stderr: true,
      stdout: true
    }
  },
  xcode: {
    command: 'open Lingu.is.xcodeproj',
    options: {
      execOptions: {
        cwd: 'cordova/platforms/ios/'
      },
      stderr: true,
      stdout: true
    }
  }
};
