//
//  DeviceDetection.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <sys/utsname.h>

//enum{
//    MODEL_UNKNOWN,
//    MODEL_IPHONE_SIMULATOR, //  maybe change?
//    MODEL_IPOD_TOUCH,
//    MODEL_IPOD_TOUCH_2G,
//    MODEL_IPOD_TOUCH_3G,
//    MODEL_IPOD_TOUCH_4G,
//    MODEL_IPHONE,
//    MODEL_IPHONE_3G,
//    MODEL_IPHONE_3GS,
//    MODEL_IPHONE_4G,
//    MODEL_IPHONE_4GS,
//    MODEL_IPHONE_5G,
//    MODEL_IPAD
//};
//
//typedef enum {
//    DeviceTypeNO = 1,
//    DeviceTypeIPhone = 2,
//    DeviceTypeIPad = 3,
//}DeviceType;
//
//typedef enum {
//    DeviceScreenTypeIPhone,
//    DeviceScreenTypeIPhone5,
//    DeviceScreenTypeIPad,
//    DeviceScreenTypeNewIpad
//}DeviceScreenType;

@interface DeviceDetection : NSObject

+ (BOOL)isOS7;
+ (BOOL)isOS8;
+ (BOOL)isIPad;
+ (BOOL)canSendSms;

#define ISIPAD [DeviceDetection isIPad]
#define ISIOS7 [DeviceDetection isOS7]
#define ISIOS8 [DeviceDetection isOS8]

@end
