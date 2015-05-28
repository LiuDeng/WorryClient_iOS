//
//  UserController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/18.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UserController.h"
#import "UserAvatarCell.h"
#import "ViewInfo.h"
#import "UserManager.h"
#import "AVOSCloud/AVOSCloud.h"
#import "User.pb.h"
#import "LogInController.h"
#import "SettingController.h"
#import "UserDetailController.h"
#import "UserService.h"
#import "ContributionController.h"

#define kTopicTitle             @"话题"
#define kBlessingTitle          @"祝福"
#define kThanksTitle            @"感谢"
#define kStoryTitle             @"故事"
#define kWorryTitle             @"心事"
#define kContributionTitle      @"贡献"
#define kFavoritesTitle         @"收藏"

@interface UserController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *sectionBasicItems;
@property (nonatomic,strong) NSArray *sectionBasicImageNames;
@property (nonatomic,assign) int indexOfSection;
@property (nonatomic,assign) int sectionAvatar;
@property (nonatomic,assign) int sectionBasic;
@property (nonatomic,assign) CGFloat avatarCellHeight;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong) PBUser *pbUser;

@end

@implementation UserController

#pragma mark - Default methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pbUser = [[UserManager sharedInstance]pbUser];
    [self.tableView reloadData];
    if ([[UserService sharedInstance]ifLogIn]) {
        //
    }else{
        [self loadLogInAlertView];
    }
}
- (void)loadView
{
    [super loadView];
    [self addRightButtonWithImageName:@"setting" target:self action:@selector(clickRightButton)];
}

- (void)loadTableView
{
    [super loadTableView];
}

- (void)loadData
{
    [super loadData];
    self.isHideTabBar = NO;
    self.sectionBasicItems = @[kContributionTitle,kFavoritesTitle,kThanksTitle,kBlessingTitle,kWorryTitle,kStoryTitle,kTopicTitle];
    self.sectionBasicImageNames = @[@"contribution",@"favorites",@"thanks",@"user_blessing",@"worry",@"story",@"topic"];
    self.sectionAvatar = self.indexOfSection++;
    self.sectionBasic = self.indexOfSection++;
}

#pragma mark - Private methods

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[UserService sharedInstance]ifLogIn]){
        // TODO
        if (indexPath.section == self.sectionAvatar) {
            [self didSelectBackgroundImage];
        }else{
            NSString *title = [self.sectionBasicItems objectAtIndex:indexPath.row];
            if ([title isEqualToString:kContributionTitle]) {
                ContributionController *vc = [[ContributionController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }else{
        [self loadLogInAlertView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == self.sectionAvatar ? 167 : kTableViewCellRowHeight;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int num;
    if (section == self.sectionAvatar) {
        num = 1;
    }else if(section == self.sectionBasic){
        num = (int)self.sectionBasicItems.count;
    }else{
        //  TODO
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == self.sectionAvatar) {
        UserAvatarCell *userAvatarCell = [[UserAvatarCell alloc]init];
        userAvatarCell.nickNameLabel.text = self.pbUser.nick;
        NSURL *avatarUrl = [NSURL URLWithString:self.pbUser.avatar];
        [userAvatarCell.avatarView.imageView sd_setImageWithURL:avatarUrl];
        NSURL *bgImageUrl = [NSURL URLWithString:self.pbUser.bgImage];
        [userAvatarCell.backgroundImageView sd_setImageWithURL:bgImageUrl];
        cell = userAvatarCell;
    }else{
        UITableViewCell *basicCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                                           reuseIdentifier:nil];
        if (indexPath.section == self.sectionBasic){
            basicCell.imageView.image = [UIImage imageNamed:self.sectionBasicImageNames[indexPath.row]];
            basicCell.textLabel.text = self.sectionBasicItems[indexPath.row];
        }else{
            //  TODO
        }

        cell = basicCell;
    }
    return cell;
}


#pragma mark - Utils

- (void)clickRightButton
{
    if([[UserService sharedInstance]ifLogIn]){
        SettingController *vc = [[SettingController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self loadLogInAlertView];
    }
}

- (void)didSelectBackgroundImage
{
    UserDetailController *vc = [[UserDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
