//
//  FollowController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/31.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FollowController.h"
#import "CommonCell.h"

#define kFollowingCell      @"followingCell"
#define kFollowerCell       @"followerCell"
#define kFollowingTitle     @"我关注的人"
#define kFollowerTitle      @"关注我的人"

@interface FollowController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *followingTableView;
@property (nonatomic,strong) UITableView *followerTableView;

@end

@implementation FollowController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    self.followingTableView = (UITableView *)[self.holderViews objectAtIndex:0];
    self.followerTableView = (UITableView *)[self.holderViews objectAtIndex:1];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.followerTableView]) {
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kFollowerCell forIndexPath:indexPath];
        cell.descriptionLabel.text = @"中中";
        cell.imageView.image = [UIImage imageNamed:@"avatar_female"];
        return cell;
    }else{
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kFollowingCell forIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:@"avatar_male"];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;   //  todo
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}
@end
