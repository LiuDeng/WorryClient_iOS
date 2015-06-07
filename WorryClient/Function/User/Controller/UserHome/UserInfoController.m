//
//  UserInfoController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserInfoController.h"
#import "AvatarView.h"
#import "UIView+DefaultView.h"

#define kHerWorrysTitle         @"她的心结"
#define kHerStorysTitle         @"她的心事"
#define kHerContributionTitle   @"她的贡献"
#define kHerFavoriteTitle       @"她的收藏"

#define kHisWorrysTitle         @"他的心结"
#define kHisStorysTitle         @"他的心事"
#define kHisContributionTitle   @"他的贡献"
#define kHisFavoriteTitle       @"他的收藏"

#define kCell                   @"cell"

@interface UserInfoController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UIImageView *genderImageView;  //  maybe need to delete
@property (nonatomic,strong) UILabel *signatureLabel;
@property (nonatomic,strong) UIButton *followingBtn;
@property (nonatomic,strong) UIButton *MSGBtn;  //  私信TA
//@property (nonatomic,strong) UIView *miscHolderView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PBUser *pbUser;
@property (nonatomic,strong) UIButton *herFollowingsBtn; //  关注
@property (nonatomic,strong) UIButton *herFollowersBtn; //  粉丝
@property (nonatomic,strong) UIButton *thankNumBtn;
@property (nonatomic,strong) UIButton *agreeNumBtn;
@property (nonatomic,strong) NSArray *tableViewTexts;

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

- (void)loadView
{
    [super loadView];
    [self loadBGImageView];
    [self loadAvatarView];
    [self loadNickLabel];
    [self loadSignatureLabel];
    [self loadMSGBtn];
    [self loadFollowingBtn];

    [self loadMiscBtns];
    [self loadTableView];

}

- (void)loadData
{
    [super loadData];
    if(self.pbUser.gender){     //  male
        self.tableViewTexts = @[kHisStorysTitle,kHisWorrysTitle,kHisContributionTitle,kHisFavoriteTitle];
    }else{
        self.tableViewTexts = @[kHerStorysTitle,kHerWorrysTitle,kHerContributionTitle,kHerFavoriteTitle];
    }
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
    [self.avatarView addTapGestureWithClickType:AvatarViewClickTypeZoom];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.bottom.equalTo(self.bgImageView.mas_centerY);
        make.width.equalTo(self.bgImageView.mas_height).with.multipliedBy(0.4);
        make.height.equalTo(self.bgImageView).with.multipliedBy(0.4);
    }];
}

- (void)loadNickLabel
{
    self.nickLabel = [[UILabel alloc]init];
    [self.bgImageView addSubview:self.nickLabel];
//    [self.nickLabel customColorByBGImageView:self.bgImageView];
    self.nickLabel.text = self.pbUser.nick;
    self.nickLabel.textColor = [UIColor whiteColor];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.top.equalTo(self.avatarView.mas_bottom);
    }];
}

- (void)loadSignatureLabel
{
    self.signatureLabel = [[UILabel alloc]init];
    [self.bgImageView addSubview:self.signatureLabel];
    self.signatureLabel.textColor = [UIColor whiteColor];
//    [self.signatureLabel customColorByBGImageView:self.bgImageView];
    self.signatureLabel.text = self.pbUser.signature;
    
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.top.equalTo(self.nickLabel.mas_bottom);
    }];
}

- (void)loadMSGBtn
{
    self.MSGBtn = [UIButton buttonWithNormalTitle:@"私信TA"];
    [self.bgImageView addSubview:self.MSGBtn];
    [self.MSGBtn addTarget:self action:@selector(clickMSGBtn) forControlEvents:UIControlEventTouchUpInside];
    self.MSGBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self.MSGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_centerX).with.multipliedBy(0.95);
        make.bottom.equalTo(self.bgImageView).with.multipliedBy(0.95);
    }];
}

- (void)loadFollowingBtn
{
    self.followingBtn = [UIButton buttonWithNormalTitle:@"+ 关注"];
    [self.bgImageView addSubview:self.followingBtn];
    self.followingBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.followingBtn addTarget:self action:@selector(clickFollowingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.followingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_centerX).with.multipliedBy(1.05);
        make.centerY.equalTo(self.MSGBtn);
    }];
}

- (void)loadMiscBtns
{
    NSString *followingsTitle = @"关注:100";
    NSString *followersTitle = @"粉丝:100";
    NSString *thankNumTitle = @"100";
    NSString *agreeNumTitle = @"100";
    
    NSArray *titles = @[followingsTitle,followersTitle,thankNumTitle,agreeNumTitle];
    NSArray *imageNames = @[@"",@"",@"user_info_thanks",@"user_info_agree"];
    CGFloat count = titles.count;
    
    NSMutableArray *btns = [[NSMutableArray alloc]init];
    for (int i = 0; i<count; i++) {
        NSString *title = [titles objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:[imageNames objectAtIndex:i]];
        UIButton *button = [[UIButton alloc]init];
        [self.view addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        CGFloat scale = (2*i+1)/count;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            /*  按钮这一栏的高度应该和tableView每行高度一样
             *  所以，这里用了kTableViewRowHeight/2，
             *  设置tableView的位置时，
             *  用了 make.top.equalTo(self.bgImageView.mas_bottom).with.offset(+kTableViewRowHeight)
             */
             
            make.centerY.equalTo(self.bgImageView.mas_bottom).with.offset(+kTableViewRowHeight/2);
            make.centerX.equalTo(self.view).with.multipliedBy(scale);
        }];

        [btns addObject:button];
    }
    
    self.herFollowingsBtn = [btns objectAtIndex:0];
    self.herFollowersBtn = [btns objectAtIndex:1];
    self.thankNumBtn = [btns objectAtIndex:2];
    self.agreeNumBtn = [btns objectAtIndex:3];
}

- (void)loadTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bgImageView.mas_bottom).with.offset(+kTableViewRowHeight);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewTexts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kGroupTableViewHeaderHeight;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    NSString *text = [self.tableViewTexts objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

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
