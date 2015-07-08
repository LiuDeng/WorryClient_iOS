//
//  AnswerController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
//  这个页面还得添加@机制，textview的位置得变换。
#import "AnswerController.h"
#import "PlaceholderTextView.h"
#import "FeedService+Answer.h"

@interface AnswerController ()

@property (nonatomic,strong) PBFeed *pbFeed;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation AnswerController

#pragma mark - Public methods

- (id)initWithPBFeed:(PBFeed *)pbFeed
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
    self.title = @"添加回答";
    [self addRightButtonWithTitle:@"发布" target:self action:@selector(clickReleaseButton)];
    [self loadTextView];
    
}

#pragma mark - Private methods

- (void)loadTextView
{
    NSString *placeholder = @"请添加回答";
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
    BOOL isAnonymous = NO;
    if (text.length>0) {
        [[FeedService sharedInstance]addAnswerForFeed:self.pbFeed.feedId
                                                 text:text
                                          isAnonymous:isAnonymous
                                                block:^(NSError *error) {
                                                    if (error) {
                                                        POST_ERROR_MSG(@"添加回答失败");
                                                    }else{
                                                        POST_SUCCESS_MSG(@"添加回答成功");
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    }
                                                }];
    }else{
        POST_ERROR_MSG(@"请输入内容");
    }

}

@end
