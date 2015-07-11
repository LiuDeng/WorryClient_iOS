//
//  ContributionController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/27.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "ContributionController.h"
#import "CommonCell.h"
#import "MJRefresh.h"
#import "FeedService+Answer.h"

#define kContributionCell   @"contributionCell"

@interface ContributionController ()

@property (nonatomic,strong) PBUser *pbUser;
@property (nonatomic,strong) NSArray *pbAnswers;

@end

@implementation ContributionController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView.header beginRefreshing];
}

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:kContributionCell];
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        //  TODO get answers where id = pbUser.id
        [[FeedService sharedInstance]getPBAnswersFromPBUser:weakSelf.pbUser.userId block:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                //
            }else{
                weakSelf.pbAnswers = pbObjects;
                [weakSelf.tableView reloadData];
            }
            [weakSelf afterRefresh];
        }];
    }];
    
}
#pragma mark - Private methods

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pbAnswers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kContributionCell forIndexPath:indexPath];
    PBAnswer *pbAnswer = self.pbAnswers[indexPath.row];
    //  get pbFeed from pbAnswer
    PBFeed *pbFeed;
    cell.imageView.image = [UIImage imageNamed:@"reply_thanks"];    //  话题图片，得先做个类似avatarView的topicView
    cell.descriptionLabel.text = pbFeed.title;  //  title
    cell.contentLabel.text = pbAnswer.text; // content
    cell.additionalLabel.text = [Utils dateStringCompareTo:pbAnswer.updatedAt]; //  time
    return cell;
}

#pragma mark - Utils


@end
