//
//  WTableViewController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/22.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "WTableViewController.h"

@interface WTableViewController ()

@end

@implementation WTableViewController

#pragma mark - Public methods


- (void)loadView
{
    [super loadView];
    [self loadTableView];
}

#pragma mark - Private methods

- (void)loadTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    CGRect footerViewFrame = self.view.bounds;
    footerViewFrame.size.height *= 0.1;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:footerViewFrame];
    
    //  add the following to avoid that tab bar cover some parts of table view.
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
}

#pragma mark - UITabelViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kGroupTableViewHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kGroupTableViewFooterHeight;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"This the default table view cell";
    return cell;
}

@end
