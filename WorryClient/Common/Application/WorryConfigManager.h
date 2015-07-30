//
//  WorryConfigManager.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWorryVersion            @"1.0"

#define kAVOSCloudAppID     @"nnikhivx7jf77tr1nfuz7xvzm207upe79rtd3w7z5k4s62m8"
#define kAVOSCloudAppKey    @"9px9mu18kjy59eaigq6h3l1xnz1lryw4q5o2kf3jtg8w6ppc"
#define kMaxCacheAge        30*24*3600   //  30(days)*24(hours)*3600(s)

#define kShareSDKAppKey         @"807f3aa14afb"
#define kShareSDKAppSecret      @"ace5099ec5b71ac468a0c60714fcee7d"
#define kShareSDKRedirectUrl    @"http://www.sharesdk.cn"

#define kSMSSDKAppKey           @"819b0d20e69b"
#define kSMSSDKAppSecret        @"3e051568102ae045a9746931d7cbc1a9"

#define kWeiboAppKey            @"3303279609"
#define kWeiboAppSecret         @"c165dc6d1624837d23981f975a90d042"
#define kQQAppId                @"1104717445"
#define kQQAppKey               @"mT3VOmc7PJRDLuCn"
#define kWeixinAppId            @"wxab49708edf4d414d"
#define kWeixinAppSecret        @"1e996f4a268c2aa3e80fbf3112ed41ea"

@interface WorryConfigManager : NSObject

@end
