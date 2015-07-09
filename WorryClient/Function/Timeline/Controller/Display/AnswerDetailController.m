//
//  AnswerDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/7/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "AnswerDetailController.h"
#import "CommentController.h"

@interface AnswerDetailController ()

@property (nonatomic,strong) PBAnswer *pbAnswer;

@end

@implementation AnswerDetailController

#pragma mark - Public methods

- (instancetype)initWithPBAnswer:(PBAnswer *)pbAnswer
{
    self = [super init];
    if (self) {
        self.pbAnswer = pbAnswer;
    }
    return self;
}
#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
    [self addRightButtonWithTitle:@"评论" target:self action:@selector(addComment)];  //  TODO
}

- (void)addComment
{
    CommentController *vc = [[CommentController alloc]initWithPBAnswer:self.pbAnswer];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
