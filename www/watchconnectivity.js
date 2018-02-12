var exec = require('cordova/exec');


//apple watch class
var ApplewatchConn = function(){};

ApplewatchConn.init = function (successCallback, errorCallback) {
    exec(successCallback, errorCallback, "WatchConnectivity", "init", []);
};

ApplewatchConn.messageReceiver = function (onNewMessageCallback, errorCallback) {
    exec(onNewMessageCallback, errorCallback, "WatchConnectivity", "messageReceiver", []);
};

ApplewatchConn.sendMessage = function (message, successCallback, errorCallback) {
    exec(successCallback, errorCallback, "WatchConnectivity", "sendMessage", [message]);
};


module.exports = ApplewatchConn;
