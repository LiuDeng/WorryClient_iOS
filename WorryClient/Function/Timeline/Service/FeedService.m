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
#import "TopicService.h"
//#import "UserService.h"
//#import "UserManager.h"

#define kFeedKey @"pbFeed"
#define kFeedClassName @"Feed"
#define kCreateUserIdKey @"createUserId"

const NSInteger kDataCount = 50;

@implementation FeedService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(FeedService)

- (void)creatFeedWithTitle:(NSString *)title
                      text:(NSString *)text
                createUser:(PBUser *)createUser
               isAnonymous:(BOOL)isAnonymous
                     topic:(NSArray *)topicArray
                  feedType:(PBFeedType)feedType
                     block:(FeedServiceErrorResultBlock)block
{
    AVObject *feed = [[AVObject alloc]initWithClassName:kFeedClassName];
    AVUser *avCurrentUser = [AVUser currentUser];
//    NSString *uuid = [Utils getUUID];
    PBFeedBuilder *pbFeedBuilder = [[PBFeedBuilder alloc]init];
//    [pbFeedBuilder setFeedId:uuid];
    [pbFeedBuilder setCreateUser:createUser];
    [pbFeedBuilder setTitle:title];
    [pbFeedBuilder setText:text];
    [pbFeedBuilder setIsAnonymous:isAnonymous];
    [pbFeedBuilder setCreatedAt:(int)time(0)];
    [pbFeedBuilder setTopicArray:topicArray];
    [pbFeedBuilder setType:feedType];
    
    PBFeed *pbFeed = [pbFeedBuilder build];
    NSData *pbFeedData = [pbFeed data];
    [feed setObject:pbFeedData forKey:kFeedKey];
    [feed setObject:avCurrentUser.objectId forKey:kCreateUserIdKey];
    
    [feed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //  update topic
            for (PBTopic *pbTopic in topicArray) {
                [[TopicService sharedInstance]updatePBTopic:pbTopic addFeedId:feed.objectId block:^(NSError *error) {
                    EXECUTE_BLOCK(block,error);
                }];
            }
        }else{
            EXECUTE_BLOCK(block,error);
        }
        
    }];
}

#pragma mark - Require feeds

- (void)requireMyNewFeedsWithBlock:(FeedServiceErrorResultBlock)block
{
    [self requireMyFeedsFrom:0 requireFeedsBlock:^{
        
    } Block:block];
}

- (void)requireMyMoreFeedsWithBlock:(FeedServiceErrorResultBlock)block
{
    [self requireMyFeedsFrom:_myRequireFeedsCount requireFeedsBlock:^{
        _myRequireFeedsCount++;  //  TODO    要是feeds剩下的已经少于myRequiredFeedCount了呢？
    } Block:block];
}

- (void)requireNewFeedsWithBlock:(FeedServiceErrorResultBlock)block
{
    [self requirePublicFeedsWithFrom:0 requireFeedsBlock:^{
        
    } Block:block];
}

- (void)requireMoreFeedsWithBlock:(FeedServiceErrorResultBlock)block
{
    [self requirePublicFeedsWithFrom:_requiredFeedsCount requireFeedsBlock:^{
        _requiredFeedsCount++;  //  TODO
    } Block:block];
}

- (void)requireNewFeedsWithPBTopic:(PBTopic *)pbTopic block:(FeedServiceErrorResultBlock)block
{
    NSUInteger dataCount = pbTopic.feedId.count;
    NSMutableArray *pbFeedDataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < dataCount; i++) {
        NSString *pbFeedId = [pbTopic.feedId objectAtIndex:i];
        AVObject *avFeed = [AVQuery getObjectOfClass:kFeedClassName objectId:pbFeedId];
        NSData *data = [avFeed objectForKey:kFeedKey];
        [pbFeedDataArray addObject:data];
    }
    if (pbFeedDataArray.count > 0) {
        [[FeedManager sharedInstance]storePBFeedDataArray:pbFeedDataArray];
    }
}

//  TODO
- (PBFeed *)pbFeedWithFeedTitle:(NSString *)title
{
    PBFeed *pbFeed;
    
    return pbFeed;
}

#pragma mark - Utils

/*  
 require public feeds from 'firstIndex'.
 In general, change the 'firstIndex' in 'requireFeedsBlock' when invoked.
 */
- (void)requirePublicFeedsWithFrom:(NSUInteger)firstIndex
                 requireFeedsBlock:(void (^)())requireFeedsBlock
                             Block:(FeedServiceErrorResultBlock)block
{
    [self requireSpecificFeedsFrom:firstIndex requireSpecificBlock:^(AVQuery *avQuery) {
        [avQuery whereKey:kCreateUserIdKey notEqualTo:@""];
    } requireFeedsBlock:requireFeedsBlock Block:block];
}

/*
 require my feeds from 'firstIndex'.
 In general, change the 'firstIndex' in 'requireFeedsBlock' when invoked.
 */
- (void)requireMyFeedsFrom:(NSUInteger)firstIndex
         requireFeedsBlock:(void (^)())requireFeedsBlock
                     Block:(FeedServiceErrorResultBlock)block
{
    [self requireSpecificFeedsFrom:firstIndex requireSpecificBlock:^(AVQuery *avQuery) {
        AVUser *avUser = [AVUser currentUser];
        [avQuery whereKey:kCreateUserIdKey equalTo:avUser.objectId];
    } requireFeedsBlock:requireFeedsBlock Block:block];
}

/*
  In general,make custom 'avQuery' by changing 'wherekey:...' in the 'requireSpecificBlock' when invoked.
 */
- (void)requireSpecificFeedsFrom:(NSUInteger)firstIndex
            requireSpecificBlock:(void (^)(AVQuery *avQuery))requireSpecificBlock
               requireFeedsBlock:(void (^)())requireFeedsBlock
                           Block:(FeedServiceErrorResultBlock)block
{
    AVQuery *avQuery = [AVQuery queryWithClassName:kFeedClassName];

    requireSpecificBlock(avQuery);
    
    avQuery.cachePolicy = kPFCachePolicyNetworkElseCache;
    avQuery.maxCacheAge = 30*24*3600;   //  30(days)*24(hours)*3600(s)
    [self requireFeedsWithQuery:avQuery from:firstIndex requireFeedsBlock:requireFeedsBlock block:block];
}

/*  
 With the help of AVQuery,require public feeds from 'firstIndex'.
 In general,change the 'firstIndex' in the 'requireFeedsBlock' when invoked.
 The block return the result of finding feeds from the service,referring to 'AVBooleanResultBlock'.
 */
- (void)requireFeedsWithQuery:(AVQuery *)avQuery
                         from:(NSUInteger)firstIndex
            requireFeedsBlock:(void (^)())requireFeedsBlock
                        block:(FeedServiceErrorResultBlock)block
{
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSMutableArray *pbFeedDataArray = [[NSMutableArray alloc]init];
            NSUInteger dataCount = objects.count > kDataCount ? kDataCount : objects.count;
            for (NSUInteger i = firstIndex; i<dataCount; i++) {
                AVObject *avObject = [objects objectAtIndex:i];
                NSData *pbFeedData = [avObject objectForKey:kFeedKey];
                
                [pbFeedDataArray addObject:pbFeedData];
                requireFeedsBlock();
            }
            [[FeedManager sharedInstance]storePBFeedDataArray:pbFeedDataArray];
            EXECUTE_BLOCK(block,error);
        }
    }];
}
@end
