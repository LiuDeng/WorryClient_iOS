//
//  UserInfoController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserInfoController.h"
#import "AvatarView.h"
#import "THLabel+Utils.h"
#import "UserManager.h"

@interface UserInfoController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) THLabel *nickLabel;
@property (nonatomic,strong) UIImageView *genderImageView;  //  maybe need to delete
@property (nonatomic,strong) THLabel *signatureLabel;
@property (nonatomic,strong) UIButton *followingBtn;
@property (nonatomic,strong) UIButton *MSGBtn;  //  私信TA
//@property (nonatomic,strong) UIView *miscHolderView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PBUser *pbUser;
@property (nonatomic,strong) UIButton *herFollowingsBtn; //  关注
@property (nonatomic,strong) UIButton *herFollowersBtn; //  粉丝
@property (nonatomic,strong) UIButton *thankNumBtn;
@property (nonatomic,strong) UIButton *agreeNumBtn;

@end

@implementation UserInfoController

#pragma mark - Default methods

- (instancetype)initWithPBUser:(PBUser *)pbUser
{
    self = [super init];
    if (self) {
        self.pbUser = [[UserManager sharedInstance]pbUser]; //  TODO
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    [self loadBGImageView];
    [self loadAvatarView];
}

- (void)loadData
{
    [super loadData];
    
}

#pragma Private methods

- (void)loadBGImageView
{
    self.bgImageView = [[UIImageView alloc]init];
    [self.view addSubview:self.bgImageView];
    NSURL *url = [NSURL URLWithString:self.pbUser.bgImage];
    [self.bgImageView sd_setImageWithURL:url];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@167);  //  TODO
    }];
}

- (void)loadAvatarView
{
    self.avatarView = [[AvatarView alloc]initWithBorderWidth:1.0f];
    [self.bgImageView addSubview:self.avatarView];
    NSURL *url = [NSURL URLWithString:self.pbUser.avatar];
    [self.avatarView sd_setImageWithURL:url];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.bottom.equalTo(self.bgImageView.mas_centerY);
    }];
}

- (void)loadNickLabel
{
    self.nickLabel = [[THLabel alloc]init];
    [self.bgImageView addSubview:self.nickLabel];
    [self.nickLabel customColorByBGImageView:self.bgImageView];
    self.nickLabel.text = self.pbUser.nick;
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.top.equalTo(self.avatarView.mas_bottom);
    }];
}

- (void)loadSignatureLabel
{
    self.signatureLabel = [[THLabel alloc]init];
    [self.bgImageView addSubview:self.signatureLabel];
    
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.top.equalTo(self.nickLabel.mas_bottom);
    }];
}

- (void)loadMSGBtn
{
    self.MSGBtn = [[UIButton alloc]init];
    [self.bgImageView addSubview:self.MSGBtn];
    [self.MSGBtn setTitle:@"私信TA" forState:UIControlStateNormal];
    [self.MSGBtn addTarget:self action:@selector(clickMSGBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.MSGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_centerX);
        make.top.equalTo(self.signatureLabel.mas_bottom);
    }];
}

- (void)loadFollowingBtn
{
    self.followingBtn = [[UIButton alloc]init];
    [self.bgImageView addSubview:self.followingBtn];
    [self.followingBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [self.followingBtn addTarget:self action:@selector(clickFollowingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.followingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_centerX);
        make.centerY.equalTo(self.MSGBtn);
    }];
}

- (void)loadHerFollowingsBtn
{
    self.herFollowingsBtn = [[UIButton alloc]init];
    [self.view addSubview:self.herFollowingsBtn];

//    NSString *title = [NSString stringWithFormat:@"粉丝数:%d",];
    NSString *title = @"关注：100";   //  if it's more than thousand?hundred,please change,this should add in Utils
    
    [self.herFollowingsBtn setTitle:title forState:UIControlStateNormal];
    
    [self.herFollowingsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_bottom);
        make.centerX.equalTo(self.view).with.multipliedBy(0.25);
    }];
}

- (void)loadHerFollowersBtn
{
    self.herFollowersBtn = [[UIButton alloc]init];
    [self.view addSubview:self.herFollowersBtn];
    NSString *title = @"粉丝：100";
    [self.herFollowersBtn setTitle:title forState:UIControlStateNormal];
    
    [self.herFollowersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.herFollowingsBtn);
        make.centerX.equalTo(self.view).with.multipliedBy(0.75);
    }];
}

- (void)loadThankNumBtn
{
    self.thankNumBtn = [[UIButton alloc]init];
    [self.view addSubview:self.thankNumBtn];
    UIImage *image = [UIImage imageNamed:@"user_info_thanks"];
    NSString *title = @"100";
    [self.thankNumBtn setTitle:title forState:UIControlStateNormal];
    [self.thankNumBtn setImage:image forState:UIControlStateNormal];
    
    [self.thankNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.herFollowingsBtn);
        make.centerX.equalTo(self.view).with.multipliedBy(1.25);
    }];
}

- (void)loadAgreeNumBtn
{
    self.agreeNumBtn = [[UIButton alloc]init];
    [self.view addSubview:self.agreeNumBtn];
    
    UIImage *image = [UIImage imageNamed:@"user_info_agree"];
    NSString *title = @"100";
    [self.agreeNumBtn setTitle:title forState:UIControlStateNormal];
    [self.agreeNumBtn setImage:image forState:UIControlStateNormal];
    
    [self.agreeNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.herFollowingsBtn);
        make.centerX.equalTo(self.view).with.multipliedBy(1.75);
    }];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

#pragma mark - Utils

- (void)clickMSGBtn
{
    //  send a message to the user
}

- (void)clickFollowingBtn
{
    //  follow the user
}

@end
