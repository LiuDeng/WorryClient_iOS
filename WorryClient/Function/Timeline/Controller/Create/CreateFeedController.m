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
#import "UIView+DefaultView.h"
#import "ViewInfo.h"
#import "ColorInfo.h"
#import "Feed.pb.h"
#import "DLRadioButton.h"
#import "SelectTopicController.h"

#define kStoryButtonTitle   @"心事"
#define kWorryButtonTitle   @"心结"

@interface CreateFeedController ()

@property (nonatomic,strong) PlaceholderTextView *placeholderTextView;
@property (nonatomic,strong) UITextField *titleTextField;
@property (nonatomic,strong) UIView *selectionHolderView;
@property (nonatomic,strong) UIButton *topicButton;
@property (nonatomic,strong) UIButton *anonymousButton;
@property (nonatomic,assign) PBFeedType feedType;
@property (nonatomic,strong) DLRadioButton *storyButton;
@property (nonatomic,strong) DLRadioButton *worryButton;
@property (nonatomic,strong) NSArray *topicIds;

@end

@implementation CreateFeedController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];

    [self addRightButtonWithImageName:@"create_feed_save" target:self action:@selector(clickRightButton)];
    [self loadTitleTextField];
    [self loadPlaceholderTextView];
    [self loadSelectionHolderView];
}

- (void)loadData
{
    [super loadData];
}

#pragma mark - Private methods
- (void)loadTitleTextField
{
    self.titleTextField = [[UITextField alloc]init];
    [self.view addSubview:self.titleTextField];
    self.titleTextField.placeholder = @"标题";
    self.titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    UIView *line = [UIView createSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
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
    
    UIView *line = [UIView createSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
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
    
    UIView *line = [UIView createSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectionHolderView.mas_bottom);
    }];
    
    
    [self loadTopicButton];
    [self loadRadioButtons];
    [self loadAnonymousButton];
}

- (void)loadTopicButton
{
    self.topicButton = [[UIButton alloc]init];
    [self.selectionHolderView addSubview:self.topicButton];
    UIImage *image = [UIImage imageNamed:@"creat_feed_topic"];
    [self.topicButton setImage:image forState:UIControlStateNormal];
    [self.topicButton setTitle:@"话题" forState:UIControlStateNormal];
    [self.topicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.topicButton addTarget:self action:@selector(clickTopicButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectionHolderView);
        make.centerY.equalTo(self.selectionHolderView);
    }];
}

static  CGFloat buttonWithScale = 0.2;    //  refer to selection holderview

- (void)loadAnonymousButton
{
    self.anonymousButton = [[UIButton alloc]init];
    [self.selectionHolderView addSubview:self.anonymousButton];
    [self.anonymousButton setTitle:@"匿名" forState:UIControlStateNormal];
    [self.anonymousButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.anonymousButton addTarget:self action:@selector(clickAnonymousButton) forControlEvents:UIControlEventTouchUpInside];
    [self.anonymousButton setImage:[UIImage imageNamed:@"creat_feed_unchecked"] forState:UIControlStateNormal];
    [self.anonymousButton setImage:[UIImage imageNamed:@"creat_feed_checked"] forState:UIControlStateSelected];
    
    
    [self.anonymousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.selectionHolderView);
        make.centerY.equalTo(self.selectionHolderView);
        make.width.equalTo(self.selectionHolderView).with.multipliedBy(buttonWithScale);
    }];
}

- (void)loadRadioButtons
{
    NSArray *titleArray = @[kStoryButtonTitle,kWorryButtonTitle];
    for (NSString *title in titleArray) {
        DLRadioButton *button = [[DLRadioButton alloc]init];
        [self.selectionHolderView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.icon = [UIImage imageNamed:@"creat_feed_unchecked"];
        button.iconSelected = [UIImage imageNamed:@"creat_feed_checked"];
        if ([title isEqualToString:kWorryButtonTitle]) {
            self.worryButton = button;
        }else if ([title isEqualToString:kStoryButtonTitle]){
            self.storyButton = button;
        }
        [self.selectionHolderView addSubview:button];
    }
    self.worryButton.otherButtons = @[self.storyButton];
    self.worryButton.selected = YES;
    
    CGFloat buttonWidth = 75.0f;
    [self.storyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.selectionHolderView.mas_centerX);
        make.centerY.equalTo(self.topicButton);
        make.width.equalTo(@(buttonWidth));
//        make.width.equalTo(self.selectionHolderView).with.multipliedBy(buttonWithScale);
    }];
    
    [self.worryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectionHolderView.mas_centerX);
        make.centerY.equalTo(self.topicButton);
        make.width.equalTo(@(buttonWidth));
//        make.width.equalTo(self.selectionHolderView).with.multipliedBy(buttonWithScale);
    }];
}

#pragma mark - Utils
- (void)clickRightButton
{
    NSString *title = self.titleTextField.text;
    NSString *text = self.placeholderTextView.text;
    NSArray *topicIds = self.topicIds;

    BOOL isAnonymous = self.anonymousButton.selected;
    self.feedType = ([self.worryButton.selectedButton isEqual: self.worryButton]) ? PBFeedTypeWorry : PBFeedTypeStory;
    
    if (title.length == 0) {
        POST_ERROR_MSG(@"请输入标题");
    }else if (text.length == 0){
        POST_ERROR_MSG(@"不能发表空白内容");
    }else if (topicIds == nil || topicIds.count == 0){
        POST_ERROR_MSG(@"请选择话题");
    }else{
        [[FeedService sharedInstance]createFeedWithTitle:title
                                                    text:text
                                             isAnonymous:isAnonymous
                                                  topics:topicIds
                                                feedType:_feedType block:^(NSError *error) {
                                                    if (error) {
                                                        POST_ERROR_MSG(@"发表失败");
                                                    }else{
                                                        POST_SUCCESS_MSG(@"发表成功");
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    }
                                                }];
    }
}

- (void)clickTopicButton
{
    SelectTopicController *vc = [[SelectTopicController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.selectTopicBlock = ^(NSArray *selectedPBTopicArray){
        self.topicIds = selectedPBTopicArray;
    };
}

- (void)clickAnonymousButton
{
    self.anonymousButton.selected = !self.anonymousButton.selected;
}

@end
