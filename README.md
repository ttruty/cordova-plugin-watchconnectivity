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
### Objective-C
```objective-c
// Setup and activate session in awakeWithContext or willActivate
if ([WCSession isSupported]) {
    WCSession *session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
}
// Implement didReceiveMessage WatchConnectivity handler/callback to receive incoming messages
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    NSString *message = [message objectForKey:@"message"];
    NSLog(@"%@",message);
    [self sendMessage:@"Message from iWatch"];
}
// Send message
- (void)sendMessage:(NSString*)message {
    NSDictionary *messageDictionary = [[NSDictionary alloc] initWithObjects:@[message] forKeys:@[@"message"]];
    [[WCSession defaultSession] sendMessage:messageDictionary
                               replyHandler:^(NSDictionary *reply) {
                                   NSLog(@"Send message success");
                               }
                               errorHandler:^(NSError *error) {
                                   NSLog(@"Send message failed");
                               }
     ];
}
```
### Swift
```swift
// Setup and activate session in awakeWithContext or willActivate
if WCSession.isSupported() {
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
}
// Implement didReceiveMessage WatchConnectivity handler/callback to receive incoming messages
func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
    let message = message["message"] as? String
    print(message)
    self.sendMessage("Message from iWatch")
}
// Send message
func sendMessage:(message: String) -> Void{
    let message = ["message": message]
    WCSession.defaultSession()!.sendMessage(["message": message], 
                                replyHandler: { (response) -> Void in
                                    print("Send message success")
                                }, errorHandler: { (error) -> Void in
                                    print("Send message failed")
                                })
     
}
```

## Credits
Written by [Venkatesh D](https://www.linkedin.com/in/dvenkateshd) and [Vagish M M](http:///)

Addapted for ionic support by Pierre-Luc Bolduc
## More Info
TODO: The plugin is very simple and short without much error handling. This is developed for an immediate need and shall be upgraded to support other platforms with error handling and improved design. 

For more information on setting up Cordova see [the documentation](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface)

For more info on plugins see the [Plugin Development Guide](http://cordova.apache.org/docs/en/4.0.0/guide_hybrid_plugins_index.md.html#Plugin%20Development%20Guide)
