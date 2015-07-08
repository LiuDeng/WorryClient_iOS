//
//  CommentController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommentController.h"
#import "PlaceholderTextView.h"

@interface CommentController ()

@property (nonatomic,strong) PBFeed *pbFeed;
@property (nonatomic,strong) PBAnswer *pbAnswer;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation CommentController

#pragma mark - Public methods

- (id)initWithPBFeed:(PBFeed *)pbFeed
{
    self = [super init];
    if (self) {
        self.pbFeed = pbFeed;
    }
    return self;
}

- (id)initWithPBAnswer:(PBAnswer *)pbAnswer
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
    self.title = @"添加评论";
    [self addRightButtonWithTitle:@"发布" target:self action:@selector(clickReleaseButton)];
    [self loadTextView];
    
}

#pragma mark - Private methods

- (void)loadTextView
{
    NSString *placeholder = @"请添加评论";
    self.textView = [[PlaceholderTextView alloc]initWithPlaceholder:placeholder];
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.view).with.multipliedBy(0.5);
    }];
}

#pragma mark - Utils

- (void)clickReleaseButton
{
    NSString *text = self.textView.text;
    BOOL isAnonymous = NO;  //
    if (text.length>0) {
        if (self.pbFeed) {
            [[FeedService sharedInstance]addCommentForFeed:self.pbFeed.feedId
                                                      text:text
                                               isAnonymous:isAnonymous
                                                     block:^(NSError *error) {
                                                         [self afterReleaseWith:error];
                                                     }];
        }else {
            [[FeedService sharedInstance]addCommentForAnswer:self.pbAnswer.answerId
                                                      text:text
                                               isAnonymous:isAnonymous
                                                     block:^(NSError *error) {
                                                         [self afterReleaseWith:error];
                                                     }];
        }
    }else{
        POST_ERROR_MSG(@"请输入评论内容");
    }
    

}

- (void)afterReleaseWith:(NSError *)error
{
    if (error) {
        POST_ERROR_MSG(@"发表失败");
    }else{
        POST_SUCCESS_MSG(@"发表成功");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end