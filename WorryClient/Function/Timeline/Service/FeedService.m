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
//#import "UserService.h"
//#import "UserManager.h"

#define kFeedKey @"pbFeed"
#define kFeedClassName @"Feed"
#define kCreateUserIdKey @"createUserId"

const NSInteger kDataCount = 50;

@implementation FeedService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(FeedService)

- (void)creatFeedWithTitle:(NSString *)title text:(NSString *)text createUser:(PBUser *)createUser isAnonymous:(BOOL)isAnonymous topic:(NSArray *)topicArray block:(FeedServiceErrorResultBlock)block
{
    AVObject *feed = [[AVObject alloc]initWithClassName:kFeedClassName];
    AVUser *avCurrentUser = [AVUser currentUser];
    [feed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            PBFeedBuilder *pbFeedBuilder = [[PBFeedBuilder alloc]init];
//            [pbFeedBuilder setCreateUser:createUser];
            [pbFeedBuilder setTitle:title];
            [pbFeedBuilder setText:text];
            [pbFeedBuilder setIsAnonymous:isAnonymous];
//            [pbFeedBuilder setTopicArray:topicArray]; //  会有问题？？？
            [pbFeedBuilder setFeedId:feed.objectId];
            
            PBFeed *pbFeed = [pbFeedBuilder build];
            NSData *pbFeedData = [pbFeed data];
            [feed setObject:pbFeedData forKey:kFeedKey];

            [feed setObject:avCurrentUser.objectId forKey:kCreateUserIdKey];
            
            [feed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
//                    [[FeedManager sharedInstance]storeFeed:pbFeed]; 不应该有这段代码
                    EXECUTE_BLOCK(block,error);
                }
            }];
        }
    }];
}

- (void)requireMyFeedsWithBlock:(FeedServiceErrorResultBlock)block
{
    AVUser *avCurrentUser = [AVUser currentUser];
    AVQuery *avQuery = [AVQuery queryWithClassName:kFeedClassName];
    [avQuery whereKey:kCreateUserIdKey equalTo:avCurrentUser.objectId];
    
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSMutableArray *pbFeedDataArray = [[NSMutableArray alloc]init];
            NSUInteger dataCount = objects.count > kDataCount ? kDataCount : objects.count;
            for (NSUInteger i = _requiredFeedsCount; i<dataCount; i++) {
                AVObject *avObject = [objects objectAtIndex:i];
                NSData *pbFeedData = [avObject objectForKey:kFeedKey];
                [pbFeedDataArray addObject:pbFeedData];
                _requiredFeedsCount++;
            }
            [[FeedManager sharedInstance]storePBFeedDataArray:pbFeedDataArray];
            EXECUTE_BLOCK(block,error);
        }
    }];
}

- (void)requireNewFeedsWithBlock:(FeedServiceErrorResultBlock)block
{
    AVQuery *avQuery = [AVQuery queryWithClassName:kFeedClassName];
    [avQuery whereKey:kCreateUserIdKey notEqualTo:@""]; // TODO may change
    
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSMutableArray *pbFeedDataArray = [[NSMutableArray alloc]init];
            NSUInteger dataCount = objects.count > kDataCount ? kDataCount : objects.count;
            for (NSUInteger i = 0; i<dataCount; i++) {
                AVObject *avObject = [objects objectAtIndex:i];
                NSData *pbFeedData = [avObject objectForKey:kFeedKey];
                [pbFeedDataArray addObject:pbFeedData];
            }
            [[FeedManager sharedInstance]storePBFeedDataArray:pbFeedDataArray];
            EXECUTE_BLOCK(block,error);
        }
    }];
}

- (void)requireMoreFeedsWithBlock:(FeedServiceErrorResultBlock)block
{
    AVQuery *avQuery = [AVQuery queryWithClassName:kFeedClassName];
    [avQuery whereKey:kCreateUserIdKey notEqualTo:@""];
    
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSMutableArray *pbFeedDataArray = [[NSMutableArray alloc]init];
            NSUInteger dataCount = objects.count > kDataCount ? kDataCount : objects.count;
            for (NSUInteger i = _requiredFeedsCount; i<dataCount; i++) {
                AVObject *avObject = [objects objectAtIndex:i];
                NSData *pbFeedData = [avObject objectForKey:kFeedKey];
                [pbFeedDataArray addObject:pbFeedData];
                _requiredFeedsCount++;
            }
            [[FeedManager sharedInstance]storePBFeedDataArray:pbFeedDataArray];
            EXECUTE_BLOCK(block,error);
        }
    }];
}
@end
