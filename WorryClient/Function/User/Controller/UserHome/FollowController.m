//
//  FollowController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/31.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FollowController.h"
#import "CommonCell.h"
#import "MJRefresh.h"
#import "UIImageView+Worry.h"

#define kFollowingCell      @"followingCell"
#define kFollowerCell       @"followerCell"
#define kFollowingTitle     @"我关注的人"
#define kFollowerTitle      @"关注我的人"

@interface FollowController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *followeeTableView;
@property (nonatomic,strong) UITableView *followerTableView;
@property (nonatomic,strong) NSArray *pbFollowees;
@property (nonatomic,strong) NSArray *pbFollowers;
@property (nonatomic,strong) PBUser *pbUser;

@end

@implementation FollowController

#pragma mark - Public methods

- (instancetype)initWithPBUser:(PBUser *)pbUser
{
    self = [super init];
    if (self) {
        self.pbUser = pbUser;
    }
    return self;
}

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    //  TODO maybe remove one of them
    [self.followeeTableView.header beginRefreshing];
    [self.followerTableView.header beginRefreshing];
}

- (void)loadData
{
    [super loadData];
    [self loadTableViews];
}

#pragma mark - Private methods

- (void)loadTableViews
{
    self.segmentTitles = @[kFollowingTitle,kFollowerTitle];
    NSArray *reusedIds  = @[kFollowingCell,kFollowerCell];
    self.holderViews = [[NSMutableArray alloc]init];
    
    for (int i=0; i<self.segmentTitles.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        NSString *reusedId = [reusedIds objectAtIndex:i];
        [tableView registerClass:[CommonCell class] forCellReuseIdentifier:reusedId];
        [self.holderViews addObject:tableView];
    }
    
    self.followeeTableView = (UITableView *)[self.holderViews objectAtIndex:0];
    self.followerTableView = (UITableView *)[self.holderViews objectAtIndex:1];
    
    __weak typeof(self) weakSelf = self;
    [self.followeeTableView addLegendHeaderWithRefreshingBlock:^{
        [[UserService sharedInstance]getUser:weakSelf.pbUser.userId followees:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                //
            }else{
                weakSelf.pbFollowees = pbObjects;
            }
            [weakSelf afterRefresh];
        }];
    }];
    
    [self.followerTableView addLegendHeaderWithRefreshingBlock:^{
        [[UserService sharedInstance]getUser:weakSelf.pbUser.userId followers:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                //
            }else{
                weakSelf.pbFollowers = pbObjects;
            }
            [weakSelf afterRefresh];
        }];
    }];
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kFollowerCell forIndexPath:indexPath];
    PBUser *pbUser;
    if ([tableView isEqual:self.followerTableView]) {
        pbUser = self.pbFollowers[indexPath.row];
    }else{
        pbUser = self.pbFollowees[indexPath.row];
    }
    cell.contentLabel.text = pbUser.nick;
    cell.descriptionLabel.text = pbUser.signature;
    [cell.imageView setAvatarWithPBUser:pbUser];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.followerTableView]) {
        return self.pbFollowers.count;
    }else{
        return self.pbFollowees.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}

#pragma mark - Utils

- (void)afterRefresh
{
    if (self.followeeTableView.header.state != MJRefreshHeaderStateIdle) {
        [self.followeeTableView.header endRefreshing];
    }else if (self.followerTableView.header.state != MJRefreshHeaderStateIdle) {
        [self.followerTableView.header endRefreshing];
    }
}


@end
