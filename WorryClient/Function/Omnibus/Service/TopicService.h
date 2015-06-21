//
//  TopicService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonService.h"
#import "Topic.pb.h"
#import "FeedService.h"

#define kTopicClassName         @"Topic"

@interface TopicService : CommonService
{
    NSUInteger _requiredTopicsCount;
}
DEFINE_SINGLETON_FOR_CLASS(TopicService)

//  该方法暂时不会开放给用户
//- (void)creatTopicWithTitle:(NSString *)title
//                      image:(UIImage *)image
//                      block:(ServiceErrorResultBlock)block;

- (void)requireNewTopicsWithBlock:(ServiceErrorResultBlock)block;
- (void)requireMoreTopicsWithBlock:(ServiceErrorResultBlock)block;

- (void)topicFrom:(PBTopic *)pbTopic addFeedFrom:(PBFeed *)pbFeed block:(ServiceErrorResultBlock)block;
- (NSArray *)pbFeedsInTopicWithId:(NSString *)topicId;
@end
