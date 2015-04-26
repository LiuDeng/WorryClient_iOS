//
//  DeviceDetection.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "DeviceDetection.h"
#import <MessageUI/MessageUI.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

@implementation DeviceDetection

#pragma mark - Public methods

static BOOL _isIOS7;

+ (BOOL)isOS7
{
    static dispatch_once_t onceToken;   // maybe change to isIOS7onceToken
    dispatch_once(&onceToken, ^{
        _isIOS7 = [self isIOSx:7];
    });
    return _isIOS7;
}

static BOOL _isIOS8;

+ (BOOL)isOS8
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _isIOS8 = [self isIOSx:8];
    });
    return _isIOS8;
}

+ (BOOL)isIOSx:(NSInteger)x
{
    NSString *version = [[UIDevice currentDevice]systemVersion];
    int versionInt = [version intValue];
    if(versionInt >= x) return YES;
    else return NO;
}

+ (BOOL)canSendSms
{
    return [MFMessageComposeViewController canSendText];
}

static BOOL _isIPad;

+ (BOOL)isIPad
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            deviceModel = MODEL_IPAD;
            _isIPad = YES;
        }else{
            _isIPad = NO;
        }
    });
    return _isIPad;
}

#pragma mark - Private methods

//+ (NSString *)platform
//{
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = malloc(size);
//    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithUTF8String:machine];
//    free(machine);
//    return platform;
//}
//
//+ (BOOL)isRetinalDisplay
//{
//    //  == 2.0 or >=2.0
//    return ([[UIScreen mainScreen]respondsToSelector:@selector(scale)] && [[UIScreen mainScreen]scale] >= 2.0) ? YES : NO;
//}
//
//
//+ (int)detectModel{
//    NSString *platform = [DeviceDetection platform];
//    if([platform isEqualToString:@"iPhone1,1"]) return MODEL_IPHONE;
//    if([platform isEqualToString:@"iPhone1,2"]) return MODEL_IPHONE_3G;
//    if([platform isEqualToString:@"iPhone2,1"]) return MODEL_IPHONE_3GS;
//    if([platform isEqualToString:@"iPhone3,1"]) return MODEL_IPHONE_4G;
//    if([platform isEqualToString:@"iPhone4,1"]) return MODEL_IPHONE_4GS;
//    if([platform isEqualToString:@"iPhone5,1"]) return MODEL_IPHONE_5G;
//    if([platform isEqualToString:@"iPod1,1"]) return MODEL_IPOD_TOUCH;
//    if([platform isEqualToString:@"iPod2,1"]) return MODEL_IPOD_TOUCH_2G;
//    if([platform isEqualToString:@"iPod3,1"]) return MODEL_IPOD_TOUCH_3G;
//    if([platform isEqualToString:@"iPod4,1"]) return MODEL_IPOD_TOUCH_4G;
//    if([platform isEqualToString:@"iPad1,1"]) return MODEL_IPAD;
//    if([platform isEqualToString:@"i386"]) return MODEL_IPHONE_SIMULATOR;
//    else return MODEL_UNKNOWN;
//}

@end
