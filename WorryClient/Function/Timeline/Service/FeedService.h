//
//  FeedService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonService.h"
#import "Feed.pb.h"
#import "TopicService.h"

#define kFeedClassName @"Feed"

@class PBTopic;

@interface FeedService : CommonService
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
                     block:(ServiceErrorResultBlock)block;

- (void)requireMyNewFeedsWithBlock:(ServiceErrorResultBlock)block;
- (void)requireMyMoreFeedsWithBlock:(ServiceErrorResultBlock)block;
- (void)requireNewFeedsWithBlock:(ServiceErrorResultBlock)block;
- (void)requireMoreFeedsWithBlock:(ServiceErrorResultBlock)block;

- (void)requireNewFeedsWithPBTopic:(PBTopic *)pbTopic block:(ServiceErrorResultBlock)block;
- (PBFeed *)pbFeedWithFeedId:(NSString *)feedId;
//  得有一个根据Topic找到大量Feed的方法，只不过这个方法要放哪？FeedService or TopicService
- (PBFeed *)pbFeedWithFeed:(AVObject *)feed;
@end
