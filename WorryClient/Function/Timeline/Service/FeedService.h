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

@class PBTopic;

typedef AVBooleanResultBlock FeedServiceBooleanResultBlock;
typedef void (^FeedServiceErrorResultBlock) (NSError *error);

@interface FeedService : NSObject
{
    NSUInteger _requiredFeedsCount;
    NSUInteger _myRequireFeedsCount;
    NSUInteger _requireFeedsByTopicCount;
}

DEFINE_SINGLETON_FOR_CLASS(FeedService)

- (void)creatFeedWithTitle:(NSString *)title
                      text:(NSString *)text
                createUser:(PBUser *)createUser
               isAnonymous:(BOOL)isAnonymous
                     topic:(NSArray *)topicArray
                  feedType:(PBFeedType)feedType
                     block:(FeedServiceErrorResultBlock)block;

- (void)requireMyNewFeedsWithBlock:(FeedServiceErrorResultBlock)block;
- (void)requireMyMoreFeedsWithBlock:(FeedServiceErrorResultBlock)block;
- (void)requireNewFeedsWithBlock:(FeedServiceErrorResultBlock)block;
- (void)requireMoreFeedsWithBlock:(FeedServiceErrorResultBlock)block;

- (void)requireNewFeedsWithPBTopic:(PBTopic *)pbTopic block:(FeedServiceErrorResultBlock)block;

@end
