# Ionic Cordova Watch Connectivity Plugin

Simple plugin that establishes iOS Watch Connectivity session with Watch OS and helps exchange of messages between an iPhone ionic application and its iWatch application.

## Installation

### With Ionic cordova-cli

If you are using [cordova-cli](https://ionicframework.com/docs/cli/cordova/plugin/), install
with:

    ionic cordova plugin add https://github.com/plbolduc/cordova-plugin-watchconnectivity.git

You can remove the plugin with :
    
    ionic cordova plugin rm cordova-plugin-applewatch-connectivity

<i>*If you are not able to pull from git on Windows try using [Git Bash](https://gitforwindows.org/)</i> 

## Xcode configuration

Add the platform to your ionic project

    ionic cordova platform add ios
    
Add applekit to your project in Xcode : 

    File -> new -> Target -> WatchOs -> Watchkit app

*After that you wont be able to run the command build, because cordova doesn't know about this platform. Instead run the command prepre.

    ionic cordova prepare ios


XcodeBuild error : Cordova/CDV.h not found is caused because 

To solve it go to your watchkit Extension setting -> Build Setting and remove the string in Objective-c Bridging header

## Use from Javascript
Edit `www/js/index.js` and add the following code inside `onDeviceReady`
```js
    var didReceiveMessage = function(message){
        var obj = JSON.parse(message);
        alert(obj.message);
    }
    var msgSendSuccess = function() {
        alert("Message send success");
    }
    var failure = function() {
        alert("Error");
    }
    var success = function() {
        sswc.messageReceiver(didReceiveMessage, failure);
        sswc.sendMessage("Message from phone", msgSendSuccess, failure);
    }
    sswc.init(success, failure);
```
## Use from iWatch extension

### Swift
```swift
//
//  InterfaceController.swift
//
//  Created by Pierre-Luc on 2018-02-14.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var testLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        
        if(WCSession.isSupported()){
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(WCSession.default.isReachable) {
            let message = ["message" : "hellow word"]
            
            WCSession.default.sendMessage(message, replyHandler:
                {(result) -> Void in
                    
                    print("Message sent!")
                    
                    
            }, errorHandler:
                
                
                {(error) -> Void in
                
                    print("Failed!")
                    print(error)
                
                
            })
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        let message = message["message"] as? String
        
        testLabel.setText(message)
        
    }
    
}
```

## Credits
Written by [Venkatesh D](https://www.linkedin.com/in/dvenkateshd) and [Vagish M M](http:///)

Addapted for ionic support by Pierre-Luc Bolduc
## More Info
TODO: The plugin is very simple and short without much error handling. This is developed for an immediate need and shall be upgraded to support other platforms with error handling and improved design. 

For more information on setting up Cordova see [the documentation](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface)

For more info on plugins see the [Plugin Development Guide](http://cordova.apache.org/docs/en/4.0.0/guide_hybrid_plugins_index.md.html#Plugin%20Development%20Guide)
