//
//  BlessingController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/31.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "BlessingController.h"
#import "CommonCell.h"

#define kReceivedTitle  @"收到的祝福"
#define kSentTitle      @"送出的祝福"
#define kReceivedCell   @"receivedCell"
#define kSentCell       @"sentCell"

@interface BlessingController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *receivedTableView;
@property (nonatomic,strong) UITableView *sentTableView;
@property (nonatomic,strong) NSMutableArray *tableViews;

@end

@implementation BlessingController

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
    self.segmentTitles = @[kReceivedTitle,kSentTitle];
    NSArray *reusedIds  = @[kReceivedCell,kSentCell];
    self.holderViews = [[NSMutableArray alloc]init];
    
    for (int i=0; i<self.segmentTitles.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        NSString *reusedId = [reusedIds objectAtIndex:i];
        [tableView registerClass:[CommonCell class] forCellReuseIdentifier:reusedId];
        [self.holderViews addObject:tableView];
    }
    
    self.receivedTableView = (UITableView *)[self.holderViews objectAtIndex:0];
    self.sentTableView = (UITableView *)[self.holderViews objectAtIndex:1];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.receivedTableView]) {
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kReceivedCell forIndexPath:indexPath];
        cell.descriptionLabel.text = @"收到xx的祝福";
        cell.imageView.image = [UIImage imageNamed:@"avatar_female"];
        return cell;
    }else{
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kSentCell forIndexPath:indexPath];
        
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
