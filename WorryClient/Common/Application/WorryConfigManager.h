//
//  WorryConfigManager.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAVOSCloudAppID     @"nnikhivx7jf77tr1nfuz7xvzm207upe79rtd3w7z5k4s62m8"
#define kAVOSCloudAppKey    @"9px9mu18kjy59eaigq6h3l1xnz1lryw4q5o2kf3jtg8w6ppc"
#define kDBName             @"worry_DB"
#define kMaxCacheAge        30*24*3600;   //  30(days)*24(hours)*3600(s)
#define kFeedDataCount      30

@interface WorryConfigManager : NSObject

@end
