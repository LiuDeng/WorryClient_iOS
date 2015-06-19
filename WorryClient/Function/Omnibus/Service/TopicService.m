//
//  TopicService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "TopicService.h"
#import "Utils.h"
#import "TopicManager.h"

#define kTopicKey               @"pbTopicData"
#define kTopicClassName         @"Topic"
#define kCreateUserIdKey        @"createUserId"
#define kImageName              @"topicIcon.jpeg"

#define kCreateUser             @"createUser"
#define kTitle                  @"title"
#define kDecription             @"decription"
#define kFollowerId             @"followers"
#define kIcon                   @"icon"
#define kFeed                   @"feed"   //  id or feed?

const NSUInteger kTopicCount = 9;

@implementation TopicService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(TopicService)

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

- (void)requireNewTopicsWithBlock:(ServiceErrorResultBlock)block
{
    [self requirePublicTopicsWithFrom:0 requireTopicsBlock:^{
        [[TopicManager sharedInstance]deleteCache];
    } Block:block];
}

- (void)requireMoreTopicsWithBlock:(ServiceErrorResultBlock)block
{
    [self requirePublicTopicsWithFrom: _requiredTopicsCount requireTopicsBlock:^{
        _requiredTopicsCount += kTopicCount;
    } Block:block];
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

- (void)refreshPBTopic:(PBTopic *)pbTopic
{
    NSData *pbTopicData = [self pbTopicDataWithTopicId:pbTopic.topicId];
    // store pbTopic into cache
    [[TopicManager sharedInstance]storePBTopicData:pbTopicData];
}

#pragma mark - Uitls

/*
 require public topics from 'firstIndex'.
 In general, change the 'firstIndex' in 'requireTopicsBlock' when invoked.
 */
- (void)requirePublicTopicsWithFrom:(NSUInteger)firstIndex
                 requireTopicsBlock:(void (^)())requireTopicsBlock
                             Block:(ServiceErrorResultBlock)block
{
    [self requireSpecificTopicsFrom:firstIndex requireSpecificBlock:^(AVQuery *avQuery) {
//        [avQuery whereKey:kCreateUserIdKey notEqualTo:@""];
        [avQuery whereKeyExists:kCreateUser];
    } requireTopicsBlock:requireTopicsBlock Block:block];
}

/*
 In general,make custom 'avQuery' by changing 'wherekey:...' in the 'requireSpecificBlock' when invoked.
 */
- (void)requireSpecificTopicsFrom:(NSUInteger)firstIndex
            requireSpecificBlock:(void (^)(AVQuery *avQuery))requireSpecificBlock
               requireTopicsBlock:(void (^)())requireTopicsBlock
                           Block:(ServiceErrorResultBlock)block
{
    AVQuery *avQuery = [AVQuery queryWithClassName:kTopicClassName];
    
    requireSpecificBlock(avQuery);
    
    avQuery.cachePolicy = kPFCachePolicyNetworkElseCache;
    avQuery.maxCacheAge = kMaxCacheAge;
    [self requireTopicsWithQuery:avQuery from:firstIndex requireTopicsBlock:requireTopicsBlock block:block];
}

/*
 With the help of AVQuery,require public topics from 'firstIndex'.
 In general,change the 'firstIndex' in the 'requireTopicsBlock' when invoked.
 The block return the result of finding topics from the service,referring to 'AVBooleanResultBlock'.
 */
- (void)requireTopicsWithQuery:(AVQuery *)avQuery
                         from:(NSUInteger)firstIndex
            requireTopicsBlock:(void (^)())requireTopicsBlock
                        block:(ServiceErrorResultBlock)block
{
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSMutableArray *pbTopicDataArray = [[NSMutableArray alloc]init];
            NSUInteger dataCount = objects.count > kTopicCount ? kTopicCount : objects.count;
            for (NSUInteger i = firstIndex; i<dataCount; i++) {
                AVObject *avObject = [objects objectAtIndex:i];
                NSData *pbTopicData = [self pbTopicDataWithTopicId:avObject.objectId];
                [pbTopicDataArray addObject:pbTopicData];
                requireTopicsBlock();
            }
            [[TopicManager sharedInstance]storePBTopicDataArray:pbTopicDataArray];
        }
        EXECUTE_BLOCK(block,error);
    }];
}


- (NSData *)pbTopicDataWithTopicId:(NSString *)topicId
{
    AVObject *avTopic = [AVQuery getObjectOfClass:kTopicClassName objectId:topicId];
    PBTopic *pbTopic = [self pbTopicWithTopic:avTopic];
    return [pbTopic data];
}

- (PBTopic *)pbTopicWithTopicId:(NSString *)topicId
{
    AVObject *avTopic = [AVQuery getObjectOfClass:kTopicClassName objectId:topicId];
    return [self pbTopicWithTopic:avTopic];
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


@end
