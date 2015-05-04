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

typedef void (^ServiceErrorResultBlock) (NSError *error);
typedef void (^ServiceImageBlock) (NSError *error,NSString *url);
typedef AVBooleanResultBlock ServiceBooleanResultBlock;

@interface CommonService : NSObject

- (void)updateImage:(UIImage *)image imageName:(NSString *)imageName block:(ServiceImageBlock)block;

@end
