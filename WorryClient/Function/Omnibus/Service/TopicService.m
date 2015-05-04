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
#define kImageName              @"topicIcon"
#define kImageKey               @"icon"

const NSUInteger kTopicCount = 10;

@implementation TopicService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(TopicService)

- (void)creatTopicWithTitle:(NSString *)title
                      image:(UIImage *)image
                      block:(ServiceErrorResultBlock)block
{    
    [self updateImage:image imageName:kImageName block:^(NSError *error, NSString *url) {
        if (error == nil) {
            AVObject *topic = [[AVObject alloc]initWithClassName:kTopicClassName];
            AVUser *avCurrentUser = [AVUser currentUser];
            NSString *uuid = [Utils getUUID];
            PBTopicBuilder *pbTopicBuilder = [PBTopic builder];
            [pbTopicBuilder setTopicId:uuid];
            [pbTopicBuilder setTitle:title];
            [pbTopicBuilder setIcon:url];
            [pbTopicBuilder setCreatedAt:(int)time(0)];
            PBTopic *pbTopic = [pbTopicBuilder build];
            
            NSData *pbTopicData = [pbTopic data];
            
            [topic setObject:pbTopicData forKey:kTopicKey];
            [topic setObject:avCurrentUser.objectId forKey:kCreateUserIdKey];
        
            [topic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    EXECUTE_BLOCK(block,error);
                }
            }];
        }
    }];    
}

- (void)requireNewTopicsWithBlock:(ServiceErrorResultBlock)block
{
    [self requirePublicTopicsWithFrom:0 requireTopicsBlock:^{
    
    } Block:block];
}

- (void)requireMoreTopicsWithBlock:(ServiceErrorResultBlock)block
{
    [self requirePublicTopicsWithFrom: _requiredTopicsCount requireTopicsBlock:^{
        _requiredTopicsCount++;
    } Block:block];
}

- (UIImage *)requireIcon
{
    UIImage *image = [self image:^AVFile *(AVObject *avTopic) {
        return [avTopic objectForKey:kImageKey];
    }];
    return image;
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
        [avQuery whereKey:kCreateUserIdKey notEqualTo:@""];
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
                NSData *pbTopicData = [avObject objectForKey:kTopicKey];
                [pbTopicDataArray addObject:pbTopicData];
                requireTopicsBlock();
            }
            [[TopicManager sharedInstance]storePBTopicDataArray:pbTopicDataArray];
            EXECUTE_BLOCK(block,error);
        }
    }];
}

- (UIImage *)image:(AVFile* (^)(AVObject *avTopic))block
{
    AVObject *avTopic = [AVObject objectWithClassName:kTopicClassName];
//    AVQuery *query = [AVQuery queryWithClassName:kTopicClassName];
//    AVObject *avTopic  = [query getObjectWithId:<#(NSString *)#>]
    AVFile *imageFile = block(avTopic);
    NSData *imageData = [imageFile getData];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}


@end
