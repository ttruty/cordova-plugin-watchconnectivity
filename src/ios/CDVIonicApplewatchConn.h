#import <Cordova/CDVPlugin.h>

@interface CDVIonicApplewatchConn : CDVPlugin <WCSessionDelegate>
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
