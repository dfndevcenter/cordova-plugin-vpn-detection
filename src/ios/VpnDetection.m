#import "VPNDetection.h"
#import <ifaddrs.h>
#import <net/if.h>

@implementation VPNDetection

- (void)isVPNConnected:(CDVInvokedUrlCommand*)command {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    BOOL isVPN = NO;

    if (getifaddrs(&interfaces) == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
            if ([name containsString:@"utun"] ||
                [name containsString:@"ppp"] ||
                [name containsString:@"ipsec"] ||
                [name containsString:@"tap"] ||
                [name containsString:@"tun"]) {
                isVPN = YES;
                break;
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isVPN];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
