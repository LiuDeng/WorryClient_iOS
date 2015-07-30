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
#import "UserService.h"

#define kFeedClassName  @"Feed"
#define kCreatedUser    @"createdUser"
#define kIsAnonymous    @"isAnonymous"
#define kText           @"text"
#define kUpdatedAt      @"updatedAt"
#define kCreatedUser    @"createdUser"
#define kType           @"type"

#define kCreatedFor     @"createdFor"

typedef void(^QueryTypeBlock)(AVQuery *query);  //  查询时，在这个block中，设置type

@class PBTopic;

@interface FeedService : CommonService
{
    NSUInteger _getFeedsCount;
}

DEFINE_SINGLETON_FOR_CLASS(FeedService)

- (void)createFeedWithTitle:(NSString *)title
                       text:(NSString *)text
                isAnonymous:(BOOL)isAnonymous
                     topics:(NSArray *)topics
                   feedType:(PBFeedType)feedType
                      block:(ServiceErrorResultBlock)block;

- (void)getNewFeedsWithBlock:(ServiceArrayResultBlock)block;
- (void)getMoreFeedsWithBlock:(ServiceArrayResultBlock)block;
//  TODO 修改feed的方法


- (PBFeed *)pbFeedWithFeedId:(NSString *)feedId;
//  得有一个根据Topic找到大量Feed的方法，只不过这个方法要放哪？FeedService or TopicService
- (PBFeed *)pbFeedWithFeed:(AVObject *)feed;
- (PBFeed *)simplePBFeedWithFeed:(AVObject *)feed;

- (void)getUser:(NSString *)userId favoriteFeeds:(ServiceArrayResultBlock)block;
- (void)getUser:(NSString *)userId storyFeeds:(ServiceArrayResultBlock)block;
- (void)getUser:(NSString *)userId worryFeeds:(ServiceArrayResultBlock)block;
- (void)sharePBFeed:(PBFeed *)pbFeed block:(ServiceErrorResultBlock)block;

@end
