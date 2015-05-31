//
//  ThanksController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "ThanksController.h"
#import "CommonCell.h"

#define kThanksCell @"thanksCell"

@interface ThanksController ()

@end

@implementation ThanksController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[CommonCell class] forCellReuseIdentifier:kThanksCell];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;  //  TODO
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kThanksCell forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"avatar_female"];
    cell.contentLabel.text = @"描述";
    cell.descriptionLabel.text = @"回答";
    cell.additionalLabel.text = @"刚刚";
    return cell;
}

#pragma mark - Private methods



@end
