//
//  FeedService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FeedService.h"
//#import "UserService.h"
//#import "UserManager.h"

#define kFeedKey @"kFeedKey"
@implementation FeedService

IMPLEMENT_SINGLETON_FOR_CLASS(FeedService)

- (void)creatFeedWithTitle:(NSString *)title text:(NSString *)text createUser:(PBUser *)createUser isAnonymous:(BOOL)isAnonymous topic:(NSArray *)topicArray block:(FeedServiceBooleanResultBlock)block
{
    PBFeedBuilder *pbFeedBuilder = [[PBFeedBuilder alloc]init];
    [pbFeedBuilder setCreateUser:createUser];
    [pbFeedBuilder setTitle:title];
    [pbFeedBuilder setText:text];
    [pbFeedBuilder setIsAnonymous:isAnonymous];
    [pbFeedBuilder setTopicArray:topicArray];
    PBFeed *pbFeed = [pbFeedBuilder build];
    NSData *pbFeedData = [pbFeed data];
    
    AVObject *feed = [[AVObject alloc]init];
    [feed setObject:pbFeedData forKey:kFeedKey];
    [feed saveInBackgroundWithBlock:block];
}
@end
