//
//  ReplyController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/7.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "ReplyController.h"
#import "AvatarView.h"
#import "UIView+DefaultView.h"
#import "Feed.pb.h"

@interface ReplyController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UIButton *commentButton;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *holderView;
@property (nonatomic,strong) UIView *miscHolderView;


@end

@implementation ReplyController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    [self hideTabBar];
    [self loadNavigationBar];
    [self loadTitleLabel];
    [self loadHolderView];
    [self loadMiscHolderView];
    [self loadTextView];
    
}

- (void)loadData
{
    [super loadData];
}

#pragma mark - Private methods

- (void)loadNavigationBar
{
    UIImage *shareImage = [UIImage imageNamed:@"story_detail_share"];
    UIImage *moreImage = [UIImage imageNamed:@"story_detail_more"];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:shareImage style:UIBarButtonItemStylePlain target:self action:@selector(clickShareButton)];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc]initWithImage:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(clickMoreButton)];
    [self.navigationItem setRightBarButtonItems:@[moreItem,shareItem]];
}

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.view addSubview:self.titleLabel];
    self.titleLabel.text = @"是时候了";//self.pbFeed.title;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
//        make.height.equalTo(self.view).with.multipliedBy(0.1);
    }];
}

- (void)loadHolderView
{
    self.holderView = [[UIView alloc]init];
    [self.view addSubview:self.holderView];
    
    [self.holderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.view).with.multipliedBy(0.1);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(+2);
    }];
    
    [self loadAvatarView];
    [self loadCommentButton];
    
    UIView *topLine = [UIView createSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.holderView.mas_top);
    }];
    
    UIView *bottomLine = [UIView createSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.holderView.mas_bottom);
    }];
}

- (void)loadAvatarView
{
    self.avatarView = [[AvatarView alloc]initWithBorderWidth:1.0f];
    [self.holderView addSubview:self.avatarView];
    PBUser *pbUser = [[UserManager sharedInstance]pbUser];
    NSURL *url = [NSURL URLWithString:pbUser.avatar];
    [self.avatarView.imageView sd_setImageWithURL:url];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.holderView);
        make.centerY.equalTo(self.holderView);
        make.height.equalTo(self.holderView);
        make.width.equalTo(self.holderView.mas_height);
    }];
}

- (void)loadCommentButton
{
    self.commentButton = [[UIButton alloc]init];
    [self.holderView addSubview:self.commentButton];
    UIImage *image = [UIImage imageNamed:@"worry_detail_thanks"];
    [self.commentButton setImage:image forState:UIControlStateNormal];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.holderView);
        make.centerY.equalTo(self.holderView);
    }];
}

- (void)loadTextView
{
    self.textView = [[UITextView alloc]init];
    [self.view addSubview:self.textView];
    self.textView.text = @"iOS系统自带的Switch开关是固定的大小,不能设置frame,这大大阻碍了我们的产品开发,所以小弟在闲暇时间写了这个自定义的Switch,不仅能够设置大小,也能设置左右开关颜色,文字,文字Font等等,对于系统的是否开关等Bool值属性也是应有尽有,可以说满足了我们对开关的所有需求,这是小弟第一次上传代码,希望大家多多支持";
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.miscHolderView.mas_top);
        make.top.equalTo(self.holderView.mas_bottom).with.offset(+2);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
    }];
}

- (void)loadMiscHolderView
{
    self.miscHolderView = [[UIView alloc]init];
    [self.view addSubview:self.miscHolderView];
    
    [self.miscHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(0.1);
    }];
}

#pragma mark - Utils

- (void)clickShareButton
{
    //  TODO
}

- (void)clickMoreButton
{
    //  TODO    
}

@end
