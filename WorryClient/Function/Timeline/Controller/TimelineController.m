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

#define kTimelineCell @"kTimelineCell"

@interface TimelineController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *pbFeedArray;

@end

@implementation TimelineController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
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
//    [self.tableView registerClass:[TimelineCell class] forCellReuseIdentifier:kTimelineCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData
{
    self.pbFeedArray = [[FeedManager sharedInstance]pbFeedArray];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.pbFeedArray.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimelineCell forIndexPath:indexPath];
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimelineCell];
    PBFeedBuilder *pbFeedBuilder = [[PBFeedBuilder alloc]init];
    [pbFeedBuilder setTitle:@"该是通过c"];
    [pbFeedBuilder setText:@"最好的方式应该是通过cell.backgroundView来改变cell的背景。按照文档说明，backgroundView始终处于 cell的最下层，所以，将cell里的其它subview背景设为[UIColor clearColor],以cell.backgroundView作为统一的背景，应该是最好的方式。"];
    NSArray *topicArray = @[@"大学",@"生活"];
    [pbFeedBuilder setTopicArray:topicArray];
    
//    PBFeed *pbFeed = [pbFeedBuilder build];

    NSData *pbFeedData = [self.pbFeedArray objectAtIndex:indexPath.row];
    PBFeed *pbFeed = [PBFeed parseFromData:pbFeedData];
    JDDebug(@"id : %@,title : %@",pbFeed.feedId,pbFeed.title);
    if (cell == nil) {
        cell = [[TimelineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTimelineCell pbFeed:pbFeed];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.view.bounds)*0.24;
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
