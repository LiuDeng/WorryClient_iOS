//
//  TopicService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
#warning topic doesn't save in cache
#import "TopicService.h"

#define kImageName              @"topicIcon.jpeg"
#define kCreateUser             @"createUser"
#define kTitle                  @"title"
#define kDecription             @"decription"
#define kFollowerId             @"followers"
#define kIcon                   @"icon"
#define kFeed                   @"feeds"   //  id or feed?

NSUInteger const kTopicCount = 9;
NSUInteger const kFeedCount = 40;

@implementation TopicService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(TopicService)

- (void)getPBTopicsWithBlock:(ServiceArrayResultBlock)block
{
    [self getPBTopicsWithAVQueryBlock:^(AVQuery *avQuery) {
        [avQuery whereKeyExists:kCreateUser];
        avQuery.limit = kTopicCount;
    } block:block];
}

- (void)getMorePBTopicsWithBlock:(ServiceArrayResultBlock)block
{
    _requiredTopicsCount += kTopicCount;
    [self getPBTopicsWithAVQueryBlock:^(AVQuery *avQuery) {
        [avQuery whereKeyExists:kCreateUser];
        avQuery.limit = _requiredTopicsCount;
    } block:block];
}

- (void)topicFrom:(PBTopic *)pbTopic addFeedFrom:(PBFeed *)pbFeed block:(ServiceErrorResultBlock)block
{
    AVObject *topic = [AVQuery getObjectOfClass:kTopicClassName objectId:pbTopic.topicId];
    AVObject *feed = [AVQuery getObjectOfClass:kFeedClassName objectId:pbFeed.feedId];
    AVRelation *relation = [topic relationforKey:kFeed];
    [relation addObject:feed];
    [topic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

- (NSArray *)pbFeedsInTopicWithId:(NSString *)topicId
{
    AVObject *topic = [AVQuery getObjectOfClass:kTopicClassName objectId:topicId];
    AVRelation *relation = [topic relationforKey:kFeed];
    NSArray *feeds = [[relation query]findObjects];
    NSMutableArray *pbFeeds = [[NSMutableArray alloc]init];
    
    for (AVObject *feed in feeds) {
        //  feed -> pbFeed
        PBFeed *pbFeed = [[FeedService sharedInstance]pbFeedWithFeed:feed];
        [pbFeeds addObject:pbFeed];
    }
    return pbFeeds;
}

- (void)getPBFeedsWithPBTopicId:(NSString *)pbTopicId block:(ServiceArrayResultBlock)block
{
    AVObject *topic = [AVQuery getObjectOfClass:kTopicClassName objectId:pbTopicId];
    AVRelation *relation = [topic relationforKey:kFeed];
    AVQuery *avQuery = [relation query];
    avQuery.limit = kFeedCount;
    
    //  the follow should be support by the FeedService.
    NSMutableArray *pbFeeds = [[NSMutableArray alloc]init];
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (AVObject *feed in objects) {
            //  feed -> pbFeed
            PBFeed *pbFeed = [[FeedService sharedInstance]pbFeedWithFeed:feed];
            [pbFeeds addObject:pbFeed];
        }
        EXECUTE_BLOCK(block,pbFeeds,error);
    }];
}

- (void)getMorePBFeedsWithPBTopicId:(NSString *)pbTopicId block:(ServiceArrayResultBlock)block
{
    AVObject *topic = [AVQuery getObjectOfClass:kTopicClassName objectId:pbTopicId];
    AVRelation *relation = [topic relationforKey:kFeed];
    AVQuery *avQuery = [relation query];
    _pbFeedsCount += kFeedCount;
    avQuery.limit = _pbFeedsCount;
    
    //  the follow should be support by the FeedService.
    NSMutableArray *pbFeeds = [[NSMutableArray alloc]init];
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (AVObject *feed in objects) {
            //  feed -> pbFeed
            PBFeed *pbFeed = [[FeedService sharedInstance]pbFeedWithFeed:feed];
            [pbFeeds addObject:pbFeed];
        }
        EXECUTE_BLOCK(block,pbFeeds,error);
    }];
}

#pragma mark - Uitls

/*
 *  custom the avQuery in avQueryBlock.
 */
- (void)getPBTopicsWithAVQueryBlock:(void (^)(AVQuery *avQuery))avQueryBlock
                           block:(ServiceArrayResultBlock)block
{
    AVQuery *avQuery = [AVQuery queryWithClassName:kTopicClassName];
    
    avQueryBlock(avQuery);
    
    avQuery.cachePolicy = kPFCachePolicyNetworkElseCache;
    avQuery.maxCacheAge = kMaxCacheAge;

    NSMutableArray *pbTopics = [[NSMutableArray alloc]init];
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (AVObject *topic in objects) {
            PBTopic *pbTopic = [self pbTopicWithTopic:topic];
            [pbTopics addObject:pbTopic];
        }
        EXECUTE_BLOCK(block,pbTopics,error);
    }];
}

- (PBTopic *)pbTopicWithTopic:(AVObject *)topic
{
    NSString *title = [topic objectForKey:kTitle];
    NSString *decription = [topic objectForKey:kDecription];
    //    NSString *creatUserId = [topic objectForKey:kCreateUserId];   //  createUser 暂时不存储
    //    NSArray *followerIds =
    NSString *icon = [topic objectForKey:kIcon];
    //    NSArray *feedIds
    int32_t createAt = topic.createdAt.timeIntervalSince1970;
    int32_t updateAt = topic.updatedAt.timeIntervalSince1970;
    
    PBTopicBuilder *builder = [PBTopic builder];
    [builder setTopicId:topic.objectId];
    [builder setTitle:title];
    [builder setDecription:decription];
    //    [builder setCreatUserId:creatUserId];
    //    builder setFollowerIdArray:<#(NSArray *)#>
    [builder setIcon:icon];
    //    builder setFeedIdArray:<#(NSArray *)#>
    [builder setCreatedAt:createAt];
    [builder setUpdatedAt:updateAt];
    return [builder build];
}

//- (void)creatTopicWithTitle:(NSString *)title
//                      image:(UIImage *)image
//                      block:(ServiceErrorResultBlock)block
//{
//    [self updateImage:image imageName:kImageName block:^(NSError *error, NSString *url) {
//        if (error == nil) {
//            AVObject *topic = [[AVObject alloc]initWithClassName:kTopicClassName];
//            AVUser *avCurrentUser = [AVUser currentUser];
//
//            [topic setObject:avCurrentUser forKey:kCreateUser];
//            [topic setObject:title forKey:kTitle];
//            [topic setObject:url forKey:kIcon];
//
//            [topic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    EXECUTE_BLOCK(block,error);
//                }
//            }];
//        }
//    }];
//}

@end
