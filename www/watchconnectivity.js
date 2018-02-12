var exec = require('cordova/exec');


//apple watch class
var ApplewatchConn = function(){};

ApplewatchConn.init = function (successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVIonicApplewatchConn", "init", []);
};

ApplewatchConn.messageReceiver = function (onNewMessageCallback, errorCallback) {
    exec(onNewMessageCallback, errorCallback, "CDVIonicApplewatchConn", "messageReceiver", []);
};

ApplewatchConn.sendMessage = function (message, successCallback, errorCallback) {
    exec(successCallback, errorCallback, "CDVIonicApplewatchConn", "sendMessage", [message]);
};


module.exports = ApplewatchConn;
