#import <Cordova/CDV.h>
#import <NetworkExtension/NetworkExtension.h>

@interface VpnDetection : CDVPlugin
- (void)isVpnEnabled:(CDVInvokedUrlCommand*)command;
@end

@implementation VpnDetection

- (void)isVpnEnabled:(CDVInvokedUrlCommand*)command {
    BOOL isVPN = NO;
    NSDictionary *settings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *keys = [settings[@"__SCOPED__"] allKeys];
    for (NSString *key in keys) {
        if ([key containsString:@"tap"] || [key containsString:@"tun"] || [key containsString:@"ppp"] || [key containsString:@"ipsec"] || [key containsString:@"ipsec0"] || [key containsString:@"utun"]) {
            isVPN = YES;
            break;
        }
    }

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:(isVPN ? 1 : 0)];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
