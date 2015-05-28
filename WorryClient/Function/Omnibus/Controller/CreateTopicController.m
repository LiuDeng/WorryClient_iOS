//
//  CreateTopicController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CreateTopicController.h"
#import "Topic.pb.h"
#import "TopicManager.h"
#import "TopicService.h"

@interface CreateTopicController ()

@end

@implementation CreateTopicController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test];
}

#pragma mark - Private methods

- (void)test
{
    NSArray *titleArray = @[@"婚姻",@"艺术",@"怀孕",@"健康",@"考试",@"梦想",@"压力",@"校园",@"爱情"];
    NSArray *imageNameArray = @[@"9@3x",@"8@3x",@"7@3x",@"6@3x",@"5@3x",@"4@3x",@"3@3x",@"2@3x",@"1@3x"];
    for (int i = 0; i<titleArray.count; i++) {
        NSString *title = titleArray[i];
        UIImage *image = [UIImage imageNamed:imageNameArray[i]];
        [[TopicService sharedInstance]creatTopicWithTitle:title image:image block:^(NSError *error) {
            if (error == nil) {
                POST_SUCCESS_MSG(@"发表成功");
            }
        }];
    }
}

@end
