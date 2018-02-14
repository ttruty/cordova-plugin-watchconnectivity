var exec = require('cordova/exec');

var PLUGIN_NAME = 'AppleWatchConnectivity';

//apple watch class
var AppleWatchConnectivity = function(){};

AppleWatchConnectivity.init = function (successCallback, errorCallback) {
    exec(successCallback, errorCallback, PLUGIN_NAME, "init", []);
};

AppleWatchConnectivity.messageReceiver = function (onNewMessageCallback, errorCallback) {
    exec(onNewMessageCallback, errorCallback, PLUGIN_NAME, "messageReceiver", []);
};

AppleWatchConnectivity.sendMessage = function (message, successCallback, errorCallback) {
    exec(successCallback, errorCallback, PLUGIN_NAME, "sendMessage", [message]);
};


module.exports = AppleWatchConnectivity;
