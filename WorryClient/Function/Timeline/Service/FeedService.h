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
    NSUInteger _getFeedsCount;
}

DEFINE_SINGLETON_FOR_CLASS(FeedService)

- (void)createFeedWithTitle:(NSString *)title
                       text:(NSString *)text
                isAnonymous:(BOOL)isAnonymous
                   pbTopics:(NSArray *)pbTopics
                   feedType:(PBFeedType)feedType
                      block:(ServiceErrorResultBlock)block;

- (void)getNewFeedsWithBlock:(ServiceArrayResultBlock)block;
- (void)getMoreFeedsWithBlock:(ServiceArrayResultBlock)block;

- (PBFeed *)pbFeedWithFeedId:(NSString *)feedId;
//  得有一个根据Topic找到大量Feed的方法，只不过这个方法要放哪？FeedService or TopicService
- (PBFeed *)pbFeedWithFeed:(AVObject *)feed;
@end
