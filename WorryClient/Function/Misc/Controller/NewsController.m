//
//  NewsController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "NewsController.h"
#import "CommonCell.h"

#define kNOTECell   @"NOTECell"
#define kMSGCell    @"MSGCell"
#define kNOTETitle  @"通知"
#define kMSGTitle   @"私信"

@interface NewsController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *NOTETableView;        //  通知
@property (nonatomic,strong) UITableView *MSGTableView;         //  私信

@end

@implementation NewsController

#pragma mark - Public methods

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
    self.segmentTitles = @[kNOTETitle,kMSGTitle];
    NSArray *reusedIds  = @[kNOTECell,kMSGCell];
    self.holderViews = [[NSMutableArray alloc]init];
    
    for (int i=0; i<self.segmentTitles.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        NSString *reusedId = [reusedIds objectAtIndex:i];
        [tableView registerClass:[CommonCell class] forCellReuseIdentifier:reusedId];
        [self.holderViews addObject:tableView];
    }
    
    self.NOTETableView = (UITableView *)[self.holderViews objectAtIndex:0];
    self.MSGTableView = (UITableView *)[self.holderViews objectAtIndex:1];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.NOTETableView) {
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kNOTECell forIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:@"avatar_male"];
        cell.descriptionLabel.text = @"用户";
        cell.dateLabel.text = @"十分钟前";
        cell.contentLabel.text = @"xx回答了你的问题";
        
        return cell;
    }else{
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kMSGCell forIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:@"avatar_female"];
        cell.descriptionLabel.text = @"用户";
        cell.dateLabel.text = @"十分钟前";
        cell.contentLabel.text = @"你好啊！";
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellRowHeight;
}

@end
