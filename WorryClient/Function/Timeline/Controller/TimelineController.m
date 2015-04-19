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
#import "CreatFeedController.h"
#import "FeedManager.h"
#import "MJRefresh.h"
#import "FeedService.h"

#define kTimelineCell @"kTimelineCell"

@interface TimelineController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *pbFeedArray;

@end

@implementation TimelineController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.header beginRefreshing];  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    [self loadData];
    [self addRightButtonWithImageName:@"plus" target:self action:@selector(clickPlusButton)];
    [self loadTableView];
}

#pragma mark - Private methods

- (void)loadTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TimelineCell class] forCellReuseIdentifier:kTimelineCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [[FeedService sharedInstance]requireNewFeedsWithBlock:^(NSError *error) {
            if (error == nil) {
                [weakSelf loadData];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.header endRefreshing];
            }
        }];
        
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [[FeedService sharedInstance]requireMoreFeedsWithBlock:^(NSError *error) {
            if (error == nil) {
                [weakSelf loadData];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.footer endRefreshing];
            }
        }];
    }];
}

- (void)loadData
{
    self.pbFeedArray = [[FeedManager sharedInstance]pbFeedArray];

//    CGFloat duration = 2.0f;
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）换在读取成功那里
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        if (self.tableView.header.state != MJRefreshHeaderStateIdle) {
//            [self.tableView.header endRefreshing];
//        }else if (self.tableView.footer.state != MJRefreshHeaderStateIdle){
//            [self.tableView.footer endRefreshing];
//        }
//    });
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
    NSData *pbFeedData = [self.pbFeedArray objectAtIndex:indexPath.row];
    PBFeed *pbFeed = [PBFeed parseFromData:pbFeedData];
    cell.titleLabel.text = pbFeed.title;
    cell.shortTextLabel.text = pbFeed.text;
    cell.commentNumLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)pbFeed.comment.count];
    NSMutableString *topicString = [[NSMutableString alloc]init];
    if (pbFeed.topic) {
        for (int i = 0; i<pbFeed.topic.count; i++) {
            NSString *topic = [pbFeed.topic objectAtIndex:i];
            if (i == pbFeed.topic.count-1) {
                [topicString appendFormat:@"%@",topic];
            }else{
                [topicString appendFormat:@"%@，",topic];
            }
        }
    }
//    cell.topicLabel.text = topicString;
    cell.topicLabel.text = @"大学";
    cell.blessingNumLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)pbFeed.blessingUser.count];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.view.bounds)*0.24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGRectGetHeight(self.view.bounds)*0.012;
}
#pragma mark - Utils

- (void)clickPlusButton
{
    CreatFeedController *vc = [[CreatFeedController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
