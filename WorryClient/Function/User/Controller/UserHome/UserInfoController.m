//
//  UserInfoController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserInfoController.h"
#import "UIView+DefaultView.h"
#import "UserInfoAvatarCell.h"
#import "UserInfoMiscCell.h"
#import "TGRImageViewController.h"

#define kHerWorrysTitle         @"她的心结"
#define kHerStorysTitle         @"她的心事"
#define kHerContributionTitle   @"她的贡献"
#define kHerFavoriteTitle       @"她的收藏"

#define kHisWorrysTitle         @"他的心结"
#define kHisStorysTitle         @"他的心事"
#define kHisContributionTitle   @"他的贡献"
#define kHisFavoriteTitle       @"他的收藏"

#define kBasicCell              @"basicCell"
#define kAvatarCell             @"avatarCell"
#define kMiscCell               @"miscCell"

@interface UserInfoController ()

@property (nonatomic,strong) PBUser *pbUser;
@property (nonatomic,strong) NSArray *tableViewTexts;
@property (nonatomic,assign) int indexOfSection;
@property (nonatomic,assign) int sectionAvatar;
@property (nonatomic,assign) int sectionBasic;
@property (nonatomic,assign) int sectionMisc;

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

- (void)loadData
{
    [super loadData];
    
    self.sectionAvatar = self.indexOfSection++;
    self.sectionMisc = self.indexOfSection++;
    self.sectionBasic = self.indexOfSection++;

    if(self.pbUser.gender){     //  male
        self.tableViewTexts = @[kHisStorysTitle,kHisWorrysTitle,kHisContributionTitle,kHisFavoriteTitle];
    }else{
        self.tableViewTexts = @[kHerStorysTitle,kHerWorrysTitle,kHerContributionTitle,kHerFavoriteTitle];
    }
}

- (void)loadView{
    [super loadView];
    self.title = @"用户详情";
}

#pragma Private methods

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kBasicCell];
    [self.tableView registerClass:[UserInfoAvatarCell class] forCellReuseIdentifier:kAvatarCell];
    [self.tableView registerClass:[UserInfoMiscCell class] forCellReuseIdentifier:kMiscCell];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num;
    
    if (section == self.sectionAvatar) {
        num = 1;
    }else if (section == self.sectionMisc){
        num = 1;
    }else {
        num = self.tableViewTexts.count;
    }
    
    return num;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexOfSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.sectionAvatar){
        return 167;
    }else{
        return kTableViewRowHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == self.sectionAvatar) {
        UserInfoAvatarCell *cell = (UserInfoAvatarCell *)[tableView cellForRowAtIndexPath:indexPath];
        TGRImageViewController *vc = [[TGRImageViewController alloc]initWithImage:cell.bgImageView.image];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (section == self.sectionMisc){
        //  do nothing
    }else{
        //  basic
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.sectionAvatar) {
        UserInfoAvatarCell *cell = (UserInfoAvatarCell *)[tableView dequeueReusableCellWithIdentifier:kAvatarCell forIndexPath:indexPath];
        NSURL *bgImageUrl = [NSURL URLWithString:self.pbUser.bgImage];
        [cell.bgImageView sd_setImageWithURL:bgImageUrl];
        
        NSURL *avatarUrl = [NSURL URLWithString:self.pbUser.avatar];
        [cell.avatarView sd_setImageWithURL:avatarUrl];
        
        cell.nickLabel.text = self.pbUser.nick;
        cell.signatureLabel.text = self.pbUser.signature;

        NSString *imageName = self.pbUser.gender ? @"user_info_male" : @"user_info_female";
        cell.genderImageView.image = [UIImage imageNamed:imageName];
        
        [cell.MSGBtn setTitle:@"私信TA" forState:UIControlStateNormal];
        [cell.MSGBtn addTarget:self action:@selector(clickMSGBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.followingBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [cell.followingBtn addTarget:self action:@selector(clickFollowingBtn) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else if (indexPath.section == self.sectionMisc){
        UserInfoMiscCell *cell = (UserInfoMiscCell *)[tableView dequeueReusableCellWithIdentifier:kMiscCell forIndexPath:indexPath];
        
        NSString *followingsTitle = @"关注:100";
        NSString *followersTitle = @"粉丝:100";
        NSString *thankNumTitle = @"100";
        NSString *agreeNumTitle = @"100";
                
        [cell.herFollowingsBtn setTitle:followingsTitle forState:UIControlStateNormal];
        [cell.herFollowersBtn setTitle:followersTitle forState:UIControlStateNormal];
        [cell.thankNumBtn setTitle:thankNumTitle forState:UIControlStateNormal];
        [cell.agreeNumBtn setTitle:agreeNumTitle forState:UIControlStateNormal];
        
        return cell;
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBasicCell forIndexPath:indexPath];
        NSString *text = [self.tableViewTexts objectAtIndex:indexPath.row];
        cell.textLabel.text = text;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
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

- (void)clickHerFollowingsBtn
{
    //  display her followings
}

- (void)clickHerFollowersBtn
{
    //  display her followers
}


@end
