//
//  AnswerDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/7/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "AnswerDetailController.h"
#import "CommentController.h"
#import "FeedService+Answer.h"

@interface AnswerDetailController ()

@property (nonatomic,strong) PBAnswer *pbAnswer;

@end

@implementation AnswerDetailController

#pragma mark - Public methods

- (instancetype)initWithPBAnswer:(PBAnswer *)pbAnswer {
    self = [super init];
    if (self) {
        self.pbAnswer = pbAnswer;
    }
    return self;
}
#pragma mark - Default methods

- (void)loadView {
    [super loadView];
    [self addRightButtonWithTitle:@"评论" target:self action:@selector(addComment)];  //  TODO
    [self addRightButtonWithTitle:@"感谢" target:self action:@selector(thankAnswer)];
}

- (void)addComment {
    CommentController *vc = [[CommentController alloc]initWithPBAnswer:self.pbAnswer];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)thankAnswer {
    [[FeedService sharedInstance]thankAnswer:self.pbAnswer block:^(NSError *error) {
        if (error) {
            POST_ERROR_MSG(NSLocalizedString(@"感谢失败", nil));
        }else{
            POST_SUCCESS_MSG(NSLocalizedString(@"感谢成功", nil));
        }
    }];
}

@end
