try {
  var exec = cordova.require('cordova/exec');

  //apple watch class
  var AppleWatchConnectivity = function(){};

  AppleWatchConnectivity.init = function (successCallback, errorCallback) {
    exec(successCallback, errorCallback, "AppleWatchConnectivity", "init", []);
  };


  AppleWatchConnectivity.messageReceiver = function (onNewMessageCallback, errorCallback) {
    exec(onNewMessageCallback, errorCallback, "AppleWatchConnectivity", "messageReceiver", []);
  };

  AppleWatchConnectivity.sendMessage = function (message, successCallback, errorCallback) {
    exec(successCallback, errorCallback, "AppleWatchConnectivity", "sendMessage", [message]);
  };


  module.exports = AppleWatchConnectivity;
} catch (error) {
  console.error(error);
}
