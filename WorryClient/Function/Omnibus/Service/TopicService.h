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

@interface TopicService : CommonService

DEFINE_SINGLETON_FOR_CLASS(TopicService)

- (void)creatTopicWithTitle:(NSString *)title
                 decription:(NSString *)decription
                      image:(UIImage *)image
                      block:(ServiceErrorResultBlock)block;

@end
