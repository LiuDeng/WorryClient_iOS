//
//  StoryController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/31.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "StoryController.h"
#import "CommonCell.h"
#import "FeedService.h"

#define kStoryCell      @"storyCell"

@interface StoryController ()
@property (nonatomic,strong) NSArray *pbFeeds;
@property (nonatomic,strong) PBUser *pbUser;
@end

@implementation StoryController
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
    [self.tableView.header beginRefreshing];
}

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:kStoryCell];
    __weak typeof(self) weakSelf = self;

    self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [[FeedService sharedInstance]getUser:weakSelf.pbUser.userId storyFeeds:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                POST_ERROR_MSG(@"网络慢，请稍候再试");
            }else{
                weakSelf.pbFeeds = pbObjects;
            }
            [weakSelf afterRefresh];
        }];
    }];
}

#pragma mark - Private methods


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoryCell forIndexPath:indexPath];
    PBFeed *pbFeed = self.pbFeeds[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"avatar_male"]; //  话题图标
    cell.contentLabel.text = pbFeed.title;
    cell.descriptionLabel.text = pbFeed.text;
    //    cell.additionalLabel.text = @"关注的人";
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pbFeeds.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}
#pragma mark - Utils

- (void)afterRefresh
{
    if (self.tableView.header.state != MJRefreshStateIdle) {
        [self.tableView.header endRefreshing];
    }
}

@end