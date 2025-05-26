#import <Cordova/CDV.h>

@interface VPNDetection : CDVPlugin

- (void)isVPNConnected:(CDVInvokedUrlCommand*)command;

@end
