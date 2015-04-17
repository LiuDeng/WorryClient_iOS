//
//  CreatFeedController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CreatFeedController.h"
#import "PlaceholderTextView.h"
#import "FeedService.h"
#import "UserManager.h"
#import "UIView+DefaultView.h"
#import "ViewInfo.h"
#import "ColorInfo.h"

@interface CreatFeedController ()
@property (nonatomic,strong)PlaceholderTextView *placeholderTextView;
@property (nonatomic,strong)UITextField *titleTextField;

@end

@implementation CreatFeedController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    [self addRightButtonWithTitle:@"提交" target:self action:@selector(clickRightButton)];
    [self loadTitleTextField];
    [self loadPlaceholderTextView];
}

#pragma mark - Private methods
- (void)loadTitleTextField
{
    self.titleTextField = [[UITextField alloc]init];
    [self.view addSubview:self.titleTextField];
    self.titleTextField.placeholder = @"标题";
    UIView *line = [UIView creatSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleTextField.mas_bottom);
    }];
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(0.9);
        make.height.equalTo(self.view).with.multipliedBy(0.08);
    }];
}

- (void)loadPlaceholderTextView
{
    NSString *placeholder = @"你的心事，我在乎，说说你的心事吧";
    self.placeholderTextView = [[PlaceholderTextView alloc]initWithPlaceholder:placeholder placeholderColor:nil placeholderFont:nil];
    [self.view addSubview:self.placeholderTextView];
    
    [self.placeholderTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(0.9);
        make.height.equalTo(self.view).with.multipliedBy(0.3);
        make.top.equalTo(self.titleTextField.mas_bottom).with.offset(+2);
    }];
    
    UIView *line = [UIView creatSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeholderTextView.mas_bottom);//.with.offset(+2);
    }];
}
#pragma mark - Utils
- (void)clickRightButton
{
    NSString *title = self.titleTextField.text;
    NSString *text = self.placeholderTextView.text;
    BOOL isAnonymous = NO;
    if (title.length == 0) {
        POST_ERROR_MSG(@"请输入标题");
    }else if (text.length == 0){
        POST_ERROR_MSG(@"不能发表空白内容");
    }else{
        PBUser *pbUser = [[UserManager sharedInstance]pbUser];
        [[FeedService sharedInstance]creatFeedWithTitle:title
                                                   text:text
                                             createUser:pbUser
                                            isAnonymous:isAnonymous
                                                  topic:nil
                                                  block:^(NSError *error) {
            if (error == nil) {
                POST_SUCCESS_MSG(@"发表成功");
            }
        }];
    }
}

@end
