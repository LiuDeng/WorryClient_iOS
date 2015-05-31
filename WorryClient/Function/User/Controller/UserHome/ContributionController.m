//
//  ContributionController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/27.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "ContributionController.h"
#import "CommonCell.h"

#define kContributionCell   @"contributionCell"

@interface ContributionController ()

@end

@implementation ContributionController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    
}

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:kContributionCell];
}
#pragma mark - Private methods

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;   //  todo
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kContributionCell forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"reply_thanks"];
    cell.descriptionLabel.text = @"题目";
    cell.contentLabel.text = @"我的回答啊啊";
    cell.dateLabel.text = @"刚刚";
    return cell;
}

#pragma mark - Utils


@end
