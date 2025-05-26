#import "VPNDetection.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation VPNDetection

- (void)isVPNConnected:(CDVInvokedUrlCommand*)command {
    CFDictionaryRef dict = CFNetworkCopySystemProxySettings();
    NSDictionary* settings = (__bridge NSDictionary*)dict;
    NSDictionary* scoped = settings[@"__SCOPED__"];

    BOOL isVPN = NO;
    for (NSString* key in scoped.allKeys) {
        if ([key containsString:@"tap"] ||
            [key containsString:@"tun"] ||
            [key containsString:@"ppp"] ||
            [key containsString:@"ipsec"] ||
            [key containsString:@"utun"]) {
            isVPN = YES;
            break;
        }
    }

    if (dict != NULL) CFRelease(dict);

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isVPN];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
