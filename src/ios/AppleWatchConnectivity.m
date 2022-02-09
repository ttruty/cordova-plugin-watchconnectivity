#import "AppleWatchConnectivity.h"

@implementation AppleWatchConnectivity
@synthesize messageReceiver;
@synthesize messageString;
- (void)init:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* callbackId = [command callbackId];
        CDVPluginResult* pluginResult = nil;
        if ([WCSession isSupported]) {
            WCSession *session = [WCSession defaultSession];
            session.delegate = self;
            [session activateSession];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"WCSession is not supported!"];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
    }];
}
// It gets invoked when a message is received by didReceiveMessage
// or alternatively through didReceiveApplicationContext
- (void)messageReceiver:(CDVInvokedUrlCommand*)command {
    NSLog(@"WatchConnectivity :: messageReceiver");
    self.messageReceiver = [command callbackId];
}

// Received a message from WCSession.default.sendMessage
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"WatchConnectivity :: didReceiveMessage :: replyHandler :: msg: %@", message);
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsDictionary : message];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.messageReceiver];
        replyHandler(message);
    });
}

// Received a message from WCSession.default.sendMessage - no replyHandler
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"WatchConnectivity :: didReceiveMessage :: msg: %@", message);
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsDictionary : message];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.messageReceiver];
    });
}
}
- (void)sendMessage:(CDVInvokedUrlCommand*)command {
    NSString* message = [[command arguments] objectAtIndex:0];
    if (message != nil) {
        self.messageString = message;
    }
    NSDictionary *messageDictionary = [[NSDictionary alloc] initWithObjects:@[message] forKeys:@[@"message"]];
    [[WCSession defaultSession] sendMessage:messageDictionary
                               replyHandler:^(NSDictionary *reply) {}
                               errorHandler:^(NSError *error) {}
     ];
}

@end
