//
//  CreateFeedController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/16.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CreateFeedController.h"
#import "PlaceholderTextView.h"
#import "FeedService.h"
#import "UserManager.h"
#import "UIView+DefaultView.h"
#import "ViewInfo.h"
#import "ColorInfo.h"
#import "Feed.pb.h"

@interface CreateFeedController ()

@property (nonatomic,strong) PlaceholderTextView *placeholderTextView;
@property (nonatomic,strong) UITextField *titleTextField;
@property (nonatomic,strong) UIView *selectionHolderView;
@property (nonatomic,strong) UIButton *topicButton;
@property (nonatomic,strong) UIButton *typeButton;
@property (nonatomic,assign) PBFeedType *feedType;
@property (nonatomic,assign) PBTopic *feedTopic;

@end

@implementation CreateFeedController

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
    [self addRightButtonWithImageName:@"create_feed_save" target:self action:@selector(clickRightButton)];
    [self loadTitleTextField];
    [self loadPlaceholderTextView];
    [self loadSelectionHolderView];
}

#pragma mark - Private methods
- (void)loadTitleTextField
{
    self.titleTextField = [[UITextField alloc]init];
    [self.view addSubview:self.titleTextField];
    self.titleTextField.placeholder = @"标题";
    self.titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    UIView *line = [UIView creatSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleTextField.mas_bottom);
    }];
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
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
        //  +10是为了让placeholder 与 titleTextField的placeholder对齐
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale).with.offset(+10);
        make.height.equalTo(self.view).with.multipliedBy(0.3);
        make.top.equalTo(self.titleTextField.mas_bottom).with.offset(+2);
    }];
    
    UIView *line = [UIView creatSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeholderTextView.mas_bottom);
    }];
}

- (void)loadSelectionHolderView
{
    self.selectionHolderView = [[UIView alloc]init];
    [self.view addSubview:self.selectionHolderView];
    
    [self.selectionHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(0.1);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.top.equalTo(self.placeholderTextView.mas_bottom);
    }];
    
    [self loadTopicButton];
    [self loadTypeButton];
}

- (void)loadTopicButton
{
    self.topicButton = [[UIButton alloc]init];
    [self.selectionHolderView addSubview:self.topicButton];
    UIImage *image = [UIImage imageNamed:@"creat_feed_topic"];
    [self.topicButton setImage:image forState:UIControlStateNormal];
    [self.topicButton setTitle:@"话题" forState:UIControlStateNormal];
    [self.topicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.typeButton addTarget:self action:@selector(clickTopicButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectionHolderView);
        make.centerY.equalTo(self.selectionHolderView);
    }];
}

- (void)loadTypeButton
{
    self.typeButton = [[UIButton alloc]init];
    [self.selectionHolderView addSubview:self.typeButton];
    [self.typeButton setTitle:@"类型" forState:UIControlStateNormal];
    [self.typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.typeButton addTarget:self action:@selector(clickTypeButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.selectionHolderView);
        make.centerY.equalTo(self.selectionHolderView);
    }];
}

#pragma mark - Utils
- (void)clickRightButton
{
    NSString *title = self.titleTextField.text;
    NSString *text = self.placeholderTextView.text;
    
    // 不应该出现在这的
    NSString *uuid = [Utils getUUID];
    PBTopicBuilder *pbTopicBuilder = [PBTopic builder];
    [pbTopicBuilder setTopicId:uuid];
    [pbTopicBuilder setTitle:@"人生"];
    PBTopic *pbTopic = [pbTopicBuilder build];
    
    NSArray *topicArray = @[pbTopic,pbTopic];
    
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
                                                  topic:topicArray
                                                  block:^(NSError *error) {
            if (error == nil) {
                POST_SUCCESS_MSG(@"发表成功");
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

- (void)clickTopicButton
{
    
}

- (void)clickTypeButton
{
    
}

@end
