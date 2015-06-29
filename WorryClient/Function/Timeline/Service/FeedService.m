//
//  FeedService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedService.h"
#import "FeedManager.h"
#import "Utils.h"
#import "TopicManager.h"
//#import "UserService.h"
//#import "UserManager.h"

#define kFeedKey @"pbFeed"
#define kCreateUserIdKey @"createUserId"

#define kFeedType       @"feedType"
#define kCreateUser     @"createUser"
#define kTitle          @"title"
#define kIsAnonymous    @"isAnonymous"
#define kText           @"text"
#define kFeedState      @"feedState"
#define kTopics         @"topics"

const NSInteger kDataCount = 50;

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
    [feed setObject:avCurrentUser forKey:kCreateUser];
    [feed setObject:text forKey:kText];
    NSNumber *type = [NSNumber numberWithInt:feedType];
    [feed setObject:type forKey:kFeedType];
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
    [query whereKeyExists:kCreateUser];
    query.limit = kDataCount;
    [self getFeedsWithQuery:query block:block];
}

- (void)getMoreFeedsWithBlock:(ServiceArrayResultBlock)block
{
    AVQuery *query = [AVQuery queryWithClassName:kFeedClassName];
    [query whereKeyExists:kCreateUser];
    query.limit = kDataCount;
    query.skip = _getFeedsCount;    //  再加载100个到底该怎么做？
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

- (PBFeed *)pbFeedWithFeed:(AVObject *)feed
{
    NSString *title = [feed objectForKey:kTitle];
    AVUser *createUser = [feed objectForKey:kCreateUser];
    //  avUser -> pbUser in UserService
    NSString *text = [feed objectForKey:kText];
    NSArray *topics = [feed objectForKey:kTopics];
    //  pointers 指向，取出来时要重新查？
    NSMutableArray *pbTopics = [[NSMutableArray alloc]init];
    for (int i=0 ; i<topics.count; i++) {
        AVObject *topic = topics[i];
        topic = [AVQuery getObjectOfClass:kTopicClassName objectId:topic.objectId];
        PBTopic *pbTopic = [[TopicService sharedInstance]pbTopicWithTopic:topic];
        [pbTopics addObject:pbTopic];
    }
    
    PBFeedBuilder *pbFeedBuilder = [PBFeed builder];
    pbFeedBuilder.feedId = feed.objectId;
    pbFeedBuilder.title = title;
    pbFeedBuilder.text = text;
    pbFeedBuilder.topicArray  = pbTopics;
    
    PBFeed *pbFeed = [pbFeedBuilder build];
    
    return pbFeed;
}

#pragma mark - Utils

- (void)getFeedsWithQuery:(AVQuery *)avQuery block:(ServiceArrayResultBlock)block
{
    avQuery.maxCacheAge = kMaxCacheAge;
    NSMutableArray *pbObjects = [[NSMutableArray alloc]init];
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==nil) {
            
//            _getFeedsCount += objects.count;    //  maybe a mistake
            
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
