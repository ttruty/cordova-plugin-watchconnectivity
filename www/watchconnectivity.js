var exec = require('cordova/exec');

//apple watch class
var AppleWatchConnectivity = function(){};

AppleWatchConnectivity.init = function (successCallback, errorCallback) {
    console.log("TEST");
    exec(successCallback, errorCallback, "AppleWatchConnectivity", "init", []);
};

AppleWatchConnectivity.messageReceiver = function (onNewMessageCallback, errorCallback) {
    exec(onNewMessageCallback, errorCallback, "AppleWatchConnectivity", "messageReceiver", []);
};

AppleWatchConnectivity.sendMessage = function (message, successCallback, errorCallback) {
    exec(successCallback, errorCallback, "AppleWatchConnectivity", "sendMessage", [message]);
};


module.exports = AppleWatchConnectivity;
