//
//  TopicService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "TopicService.h"
#import "Utils.h"

#define kTopicKey               @"pbTopic"
#define kTopicClassName         @"Topic"
#define kCreateUserIdKey        @"createUserId"
#define kImageName              @"topicIcon"

@implementation TopicService

#pragma mark - Public methods

IMPLEMENT_SINGLETON_FOR_CLASS(TopicService)

- (void)creatTopicWithTitle:(NSString *)title
                 decription:(NSString *)decription
                      image:(UIImage *)image
                      block:(ServiceErrorResultBlock)block
{    
    [self updateImage:image imageName:kImageName block:^(NSError *error, NSString *imageUrl) {
        if (error == nil) {
            AVObject *topic = [[AVObject alloc]initWithClassName:kTopicClassName];
            AVUser *avCurrentUser = [AVUser currentUser];
            NSString *uuid = [Utils getUUID];
            PBTopicBuilder *pbTopicBuilder = [PBTopic builder];
            [pbTopicBuilder setTopicId:uuid];
            [pbTopicBuilder setTitle:title];
            [pbTopicBuilder setDecription:decription];
            [pbTopicBuilder setIcon:imageUrl];
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


@end
