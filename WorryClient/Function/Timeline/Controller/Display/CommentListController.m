//
//  CommentListController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/7/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommentListController.h"
#import "CommentController.h"

@interface CommentListController ()

@property (nonatomic,strong) PBFeed *pbFeed;

@end

@implementation CommentListController

#pragma mark - Public methods

- (instancetype)initWithPBFeed:(PBFeed *)pbFeed
{
    self = [super init];
    if (self) {
        self.pbFeed = pbFeed;
    }
    return self;
}

#pragma mark - Default methods

- (void)loadView
{
    [super loadView];
    [self addRightButtonWithTitle:@"写评论" target:self action:@selector(addComment)];
}

#pragma mark - Utils

- (void)addComment
{
    CommentController *vc = [[CommentController alloc]initWithPBFeed:self.pbFeed];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
