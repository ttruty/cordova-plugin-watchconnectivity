/********* AppleWatch.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <WatchConnectivity/WatchConnectivity.h>
@interface AppleWatch : CDVPlugin <WCSessionDelegate>
{
    NSString *messageReceiver;
    NSString *messageString;
}
@property (nonatomic, copy) NSString *messageReceiver;
@property (nonatomic, copy) NSString *messageString;

- (void) init:(CDVInvokedUrlCommand*)command;
- (void) messageReceiver:(CDVInvokedUrlCommand*)command;
- (void) sendMessage:(CDVInvokedUrlCommand*)command;
@end