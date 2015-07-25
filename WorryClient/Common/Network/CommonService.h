//
//  CommonService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "AVOSCloud/AVOSCloud.h"
#import "Utils.h"
#import "WorryConfigManager.h"
#import <ShareSDK/ShareSDK.h>

typedef void (^ServiceErrorResultBlock) (NSError *error);
typedef void (^ServiceImageBlock) (NSError *error,NSString *url);
typedef void (^ServiceBooleanResultBlock) (BOOL succeed);
typedef void (^ServiceArrayResultBlock)(NSArray *pbObjects, NSError *error);
typedef void (^ServiceAVQueryBlock) (AVQuery *avQuery);
@interface CommonService : NSObject

- (void)updateImage:(UIImage *)image imageName:(NSString *)imageName block:(ServiceImageBlock)block;
@end
