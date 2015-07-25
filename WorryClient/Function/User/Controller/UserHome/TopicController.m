//
//  TopicController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/31.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "TopicController.h"
#import "CommonCell.h"
#import "TopicService.h"

#define kTopicCell      @"storyCell"

@interface TopicController ()
@property (nonatomic,strong) NSArray *pbTopics;
@property (nonatomic,strong) PBUser *pbUser;
@end

@implementation TopicController
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
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:kTopicCell];
    __weak typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [[TopicService sharedInstance]getUser:weakSelf.pbUser.userId topics:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                POST_ERROR_MSG(@"网络慢，请稍候再试");
            }else{
                weakSelf.pbTopics = pbObjects;
            }
            [weakSelf afterRefresh];
        }];
    }];

}

#pragma mark - Private methods


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopicCell forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"avatar_male"];
    cell.additionalLabel.text = @"关注的人";
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pbTopics.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}

@end