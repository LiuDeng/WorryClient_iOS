//
//  FeedService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "AVOSCloud/AVOSCloud.h"
#import "Feed.pb.h"

typedef AVBooleanResultBlock FeedServiceBooleanResultBlock;
@interface FeedService : NSObject

DEFINE_SINGLETON_FOR_CLASS(FeedService)

- (void)creatFeedWithTitle:(NSString *)title text:(NSString *)text createUser:(PBUser *)createUser isAnonymous:(BOOL)isAnonymous topic:(NSArray *)topicArray block:(FeedServiceBooleanResultBlock)block;
@end
