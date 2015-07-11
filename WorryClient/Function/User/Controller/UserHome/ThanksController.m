//
//  ThanksController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "ThanksController.h"
#import "CommonCell.h"
#import "MJRefresh.h"
#import "FeedService+Answer.h"
#import "UIImageView+Worry.h"

#define kThanksCell @"thanksCell"

@interface ThanksController ()
@property (nonatomic,strong) NSArray *pbThanksArray;
@property (nonatomic,strong) PBUser *pbUser;
@end

@implementation ThanksController
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
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:kThanksCell];
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [[FeedService sharedInstance]getUser:weakSelf.pbUser.userId pbThanksArray:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                POST_ERROR_MSG(@"网络慢，请稍候再试");
            }else{
                weakSelf.pbThanksArray = pbObjects;
            }
            [weakSelf afterRefresh];
        }];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pbThanksArray.count;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kThanksCell forIndexPath:indexPath];
//    cell.imageView.image = [UIImage imageNamed:@"avatar_female"];
//    cell.contentLabel.text = @"描述";
//    cell.descriptionLabel.text = @"回答";
//    cell.additionalLabel.text = @"刚刚";
    PBThanks *pbThanks = self.pbThanksArray[indexPath.row];
    PBUser *fromUser = pbThanks.fromUser;
    PBAnswer *pbAnswer = pbThanks.forAnswer;
    [cell.imageView setAvatarWithPBUser:fromUser];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@感谢你的回答",fromUser.nick];
    cell.descriptionLabel.text = pbAnswer.text;
    return cell;
}

#pragma mark - Private methods

#pragma mark - Utils

- (void)afterRefresh
{
    if (self.tableView.header.state != MJRefreshHeaderStateIdle) {
        [self.tableView.header endRefreshing];
    }
}


@end
