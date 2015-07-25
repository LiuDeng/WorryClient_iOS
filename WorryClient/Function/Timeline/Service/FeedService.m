//
//  FeedService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedService.h"
#import "Utils.h"

#define kTitle          @"title"
#define kFeedState      @"state"
#define kTopics         @"topics"

const NSInteger kDataCount = 100;

@implementation FeedService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(FeedService)

- (void)createFeedWithTitle:(NSString *)title
                      text:(NSString *)text
               isAnonymous:(BOOL)isAnonymous
                     pbTopics:(NSArray *)pbTopics
                  feedType:(PBFeedType)feedType
                     block:(ServiceErrorResultBlock)block
{
    AVObject *feed = [[AVObject alloc]initWithClassName:kFeedClassName];
    AVUser *avCurrentUser = [AVUser currentUser];
    [feed setObject:title forKey:kTitle];
    [feed setObject:avCurrentUser forKey:kCreatedUser];
    [feed setObject:text forKey:kText];
    NSNumber *type = [NSNumber numberWithInt:feedType];
    [feed setObject:type forKey:kType];
    NSNumber *anonymous = [NSNumber numberWithBool:isAnonymous];
    [feed setObject:anonymous forKey:kIsAnonymous];
    
    NSMutableArray *topics = [[NSMutableArray alloc]init];
    for (PBTopic *pbTopic in pbTopics) {
        AVObject *topic = [AVQuery getObjectOfClass:kTopicClassName objectId:pbTopic.topicId];
        [topics addObject:topic];
    }
    [feed setObject:topics forKey:kTopics];
    
    [feed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        EXECUTE_BLOCK(block,error);
    }];
}

#pragma mark - Require feeds

- (void)getNewFeedsWithBlock:(ServiceArrayResultBlock)block
{
    AVQuery *query = [AVQuery queryWithClassName:kFeedClassName];
    [query whereKeyExists:kCreatedUser];
    query.limit = kDataCount;
    [self getFeedsWithQuery:query block:block];
}

- (void)getMoreFeedsWithBlock:(ServiceArrayResultBlock)block
{
    AVQuery *query = [AVQuery queryWithClassName:kFeedClassName];
    [query whereKeyExists:kCreatedUser];
    query.limit += kDataCount;
    [self getFeedsWithQuery:query block:block];
}

- (PBFeed *)pbFeedWithFeedTitle:(NSString *)title
{
    AVQuery *query = [AVQuery queryWithClassName:kFeedClassName];
    [query whereKey:kTitle equalTo:title];
    AVObject *feed = [query getFirstObject];
    PBFeed *pbFeed = [self pbFeedWithFeed:feed];
    return pbFeed;
}

- (PBFeed *)pbFeedWithFeedId:(NSString *)feedId
{
    AVQuery *query = [AVQuery queryWithClassName:kFeedClassName];
    AVObject *feed = [query getObjectWithId:feedId];
    PBFeed *pbFeed = [self pbFeedWithFeed:feed];
    return pbFeed;
}

/**
 *  Turn 'feed' to 'pbFeed' with all info
 *
 *  @param feed AVObject with class "Feed"
 *
 *  @return pbFeed with all info
 */
- (PBFeed *)pbFeedWithFeed:(AVObject *)feed
{
    NSString *title = [feed objectForKey:kTitle];
    AVUser *createdUser = [feed objectForKey:kCreatedUser];
    //  pbUser from avUser,but only get the base info:id,avatar,nick
    PBUser *pbUser = [[UserService sharedInstance]simplePBUserWithUser:createdUser];
    NSString *text = [feed objectForKey:kText];
    NSArray *topics = [feed objectForKey:kTopics];
    NSMutableArray *pbTopics = [[NSMutableArray alloc]init];
    for (int i=0 ; i<topics.count; i++) {
        AVObject *topic = topics[i];
        PBTopic *pbTopic = [[TopicService sharedInstance]pbTopicWithTopic:topic];
        [pbTopics addObject:pbTopic];
    }
    
    NSNumber *typeNum = [feed objectForKey:kType];
    int type = [typeNum intValue];
    
    PBFeedBuilder *pbFeedBuilder = [PBFeed builder];
    pbFeedBuilder.feedId = feed.objectId;
    pbFeedBuilder.title = title;
    pbFeedBuilder.text = text;
    pbFeedBuilder.topicArray  = pbTopics;
    pbFeedBuilder.type = type;
    pbFeedBuilder.createdUser = pbUser;
    
    PBFeed *pbFeed = [pbFeedBuilder build];
    
    return pbFeed;
}

/*
 @param feed AVObject
 @return pbFeed with basic info:id,title,type
 */
- (PBFeed *)simplePBFeedWithFeed:(AVObject *)feed
{
    NSString *title = [feed objectForKey:kTitle];
//    AVUser *createdUser = [feed objectForKey:kCreatedUser];
    //  pbUser from avUser,but only get the base info:id,avatar,nick
//    PBUser *pbUser = [[UserService sharedInstance]simplePBUserWithUser:createdUser];
    NSString *text = [feed objectForKey:kText];
//    NSArray *topics = [feed objectForKey:kTopics];
//    NSMutableArray *pbTopics = [[NSMutableArray alloc]init];
//    for (int i=0 ; i<topics.count; i++) {
//        AVObject *topic = topics[i];
//        //       TODO topic = [topic fetchIfNeeded];
//        topic = [AVQuery getObjectOfClass:kTopicClassName objectId:topic.objectId];
//        PBTopic *pbTopic = [[TopicService sharedInstance]pbTopicWithTopic:topic];
//        [pbTopics addObject:pbTopic];
//    }
    
    NSNumber *typeNum = [feed objectForKey:kType];
    int type = [typeNum intValue];
    
    PBFeedBuilder *pbFeedBuilder = [PBFeed builder];
    pbFeedBuilder.feedId = feed.objectId;
    pbFeedBuilder.title = title;
    pbFeedBuilder.text = text;
//    pbFeedBuilder.topicArray  = pbTopics;
    pbFeedBuilder.type = type;
//    pbFeedBuilder.createdUser = pbUser;
    
    PBFeed *pbFeed = [pbFeedBuilder build];
    
    return pbFeed;
}


- (void)getUser:(NSString *)userId favoriteFeeds:(ServiceArrayResultBlock)block
{
    AVUser *user = [AVUser objectWithoutDataWithClassName:kUserClassName objectId:userId];
    AVRelation *relation = [user relationforKey:kFavoriteFeeds];
    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *pbObjects = [[NSMutableArray alloc]init];
        if (error==nil) {
            // objects 包含了当前用户收藏的所有回答
            for (AVObject *object in objects) {
                //  object -> pbObject
                PBFeed *pbFeed = [[FeedService sharedInstance]simplePBFeedWithFeed:object];
                //  pbObjectds add pbObject
                [pbObjects addObject:pbFeed];
            }
        }
        EXECUTE_BLOCK(block,pbObjects,error);
    }];
}

- (void)getUser:(NSString *)userId storyFeeds:(ServiceArrayResultBlock)block
{
    [self getUser:userId typeBlock:^(AVQuery *query) {
        NSNumber *typeNum = [NSNumber numberWithInt:PBFeedTypeStory];
        [query whereKey:kType equalTo:typeNum];
    } feeds:block];
}

- (void)getUser:(NSString *)userId worryFeeds:(ServiceArrayResultBlock)block
{
    [self getUser:userId typeBlock:^(AVQuery *query) {
        NSNumber *typeNum = [NSNumber numberWithInt:PBFeedTypeWorry];
        [query whereKey:kType equalTo:typeNum];
    } feeds:block];
}

- (void)getUser:(NSString *)userId
      typeBlock:(QueryTypeBlock)queryTypeBlock
          feeds:(ServiceArrayResultBlock)block
{
    AVUser *user = [AVUser objectWithoutDataWithClassName:kUserClassName objectId:userId];
    AVQuery *query = [AVQuery queryWithClassName:kFeedClassName];
    [query whereKey:kCreatedUser equalTo:user];
    EXECUTE_BLOCK(queryTypeBlock,query);
    [self getFeedsWithQuery:query block:block];
}

- (void)sharePBFeed:(PBFeed *)pbFeed block:(ServiceErrorResultBlock)block
{
//    [self shareContent:pbFeed.text title:pbFeed.title];
}
#pragma mark - Utils
//  TODO 如果只是获取消息流的feeds，不用所有信息都获取，只需获取一部分

- (void)getFeedsWithQuery:(AVQuery *)avQuery block:(ServiceArrayResultBlock)block
{
    avQuery.maxCacheAge = kMaxCacheAge;
    avQuery.cachePolicy = kAVCachePolicyNetworkElseCache;
    [avQuery orderByDescending:kUpdatedAt];
    [avQuery includeKey:kTopics];
    NSMutableArray *pbObjects = [[NSMutableArray alloc]init];
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==nil) {
        
            //  objects->object->pbObject->pbObjects
            for (AVObject *avObject in objects) {
                PBFeed *pbFeed = [self pbFeedWithFeed:avObject];
                [pbObjects addObject:pbFeed];
            }
        }
        EXECUTE_BLOCK(block,pbObjects,error);
    }];
}



@end
