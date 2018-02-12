var exec = require('cordova/exec');


//apple watch class
var AppleWatch = function(){};

AppleWatch.init = function (successCallback, errorCallback) {
    exec(successCallback, errorCallback, "AppleWatch", "init", []);
};

AppleWatch.messageReceiver = function (onNewMessageCallback, errorCallback) {
    exec(onNewMessageCallback, errorCallback, "AppleWatch", "messageReceiver", []);
};

AppleWatch.sendMessage = function (message, successCallback, errorCallback) {
    exec(successCallback, errorCallback, "AppleWatch", "sendMessage", [message]);
};


module.exports = AppleWatch;
