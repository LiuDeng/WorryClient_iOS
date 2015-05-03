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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)test
{
    NSString *title = @"人生";
    NSString *decription = @"此话题沉重";
    UIImage *image = [UIImage imageNamed:@"avatar01"];
    [[TopicService sharedInstance]creatTopicWithTitle:title decription:decription image:image block:^(NSError *error) {
        if (error == nil) {
            POST_SUCCESS_MSG(@"发表成功");
        }
    }];
}

- (void)getTest
{
    
}

@end
