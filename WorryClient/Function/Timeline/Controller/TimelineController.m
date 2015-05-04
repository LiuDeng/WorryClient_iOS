//
//  TimelineController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "TimelineController.h"
#import "TimelineCell.h"
#import "Feed.pb.h"
#import "CreateFeedController.h"
#import "FeedManager.h"
#import "MJRefresh.h"
#import "FeedService.h"
#import "StoryDetailController.h"
#import "WorryDetailController.h"

#define kTimelineCell @"kTimelineCell"

@interface TimelineController ()

@property (nonatomic,strong) NSArray *pbFeedArray;

@end

@implementation TimelineController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.header beginRefreshing];  
}

- (void)loadView
{
    [super loadView];
    [self addRightButtonWithImageName:@"plus" target:self action:@selector(clickPlusButton)];
}

#pragma mark - Private methods

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[TimelineCell class] forCellReuseIdentifier:kTimelineCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [[FeedService sharedInstance]requireNewFeedsWithBlock:^(NSError *error) {
            if(error==nil){
                [weakSelf afterRefresh];
            }
        }];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [[FeedService sharedInstance]requireMoreFeedsWithBlock:^(NSError *error) {
            if(error==nil){
                [weakSelf afterRefresh];
            }
        }];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pbFeedArray.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimelineCell forIndexPath:indexPath];
    PBFeed *pbFeed = [self.pbFeedArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = pbFeed.title;
    cell.shortTextLabel.text = pbFeed.text;
    NSString *commentNum = [NSString stringWithFormat:@"%lu",(unsigned long)pbFeed.comment.count];
    [cell.commentButton setTitle:commentNum forState:UIControlStateNormal];
    PBTopic *pbTopic = [pbFeed.topic firstObject];
    NSString *topicString = pbTopic.title;
    [cell.topicButton setTitle:topicString forState:UIControlStateNormal];
    NSString *blessingNum = [NSString stringWithFormat:@"%lu",(unsigned long)pbFeed.blessing.count];
    [cell.blessingButton setTitle:blessingNum forState:UIControlStateNormal];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryDetailController *vc = [[StoryDetailController alloc]init];
//    WorryDetailController *vc = [[WorryDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.view.bounds)*0.24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGRectGetHeight(self.view.bounds)*0.012;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - Utils

- (void)clickPlusButton
{
    if ([[UserService sharedInstance]ifLogIn]) {
        CreateFeedController *vc = [[CreateFeedController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self loadLogInAlertView];
    }
    
}

- (void)afterRefresh
{
    self.pbFeedArray = [[FeedManager sharedInstance]pbFeedArray];
    [self.tableView reloadData];
    if (self.tableView.header.state != MJRefreshHeaderStateIdle) {
        [self.tableView.header endRefreshing];
    }else if (self.tableView.footer.state != MJRefreshHeaderStateIdle){
        [self.tableView.footer endRefreshing];
    }
}

@end
