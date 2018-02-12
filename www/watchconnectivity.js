var exec = require('cordova/exec');


//apple watch class
var ApplewatchConn = function(){};

ApplewatchConn.init = function (successCallback, errorCallback) {
    exec(successCallback, errorCallback, "AppleWatch", "init", []);
};

ApplewatchConn.messageReceiver = function (onNewMessageCallback, errorCallback) {
    exec(onNewMessageCallback, errorCallback, "AppleWatch", "messageReceiver", []);
};

ApplewatchConn.sendMessage = function (message, successCallback, errorCallback) {
    exec(successCallback, errorCallback, "AppleWatch", "sendMessage", [message]);
};


module.exports = ApplewatchConn;
