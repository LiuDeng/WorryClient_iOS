//
//  FavoriteController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "FavoriteController.h"
#import "FavoriteWorryCell.h"
#import "FavoriteStoryCell.h"

#define kWorryCell      @"worryCell"
#define kStoryCell      @"storyCell"
#define kWorryTitle     @"心结"
#define kStoryTitle     @"心事"

@interface FavoriteController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *storyTableView;
@property (nonatomic,strong) UITableView *worryTableView;

@end

@implementation FavoriteController

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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;  //  TODO
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.worryTableView) {
        FavoriteWorryCell *cell = [tableView dequeueReusableCellWithIdentifier:kWorryCell forIndexPath:indexPath];
        
        cell.titleLabel.text = @"题目";
        cell.answerLabel.text = @"一定要多加几个程序员啊啊一定要多加几个程序员啊啊一定要多加几个程序员啊啊一定要多加几个程序员啊啊";
        cell.thanksLabel.text = @"感谢：3";
        cell.commentLabel.text = @"评论：10";
        
        return cell;
    }else{
        FavoriteStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoryCell forIndexPath:indexPath];
        
        cell.titleLabel.text = @"成绩怎么提不上去啊";
        cell.contentLabel.text = @"成绩怎么提不上去啊成绩怎么提不上去啊成绩怎么提不上去啊成绩怎么提不上去啊";
        cell.thanksLabel.text = @"感谢：3";
        cell.commentLabel.text = @"评论：10";
        
        return cell;
    }
}

#pragma mark - Private methods

- (void)loadTableViews
{
    self.segmentTitles = @[kWorryTitle,kStoryTitle];
    NSArray *reusedIds  = @[kWorryCell,kStoryCell];
    self.holderViews = [[NSMutableArray alloc]init];
    NSArray *cellClasses = @[[FavoriteWorryCell class],[FavoriteStoryCell class]];
    
    for (int i=0; i<self.segmentTitles.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        NSString *reusedId = [reusedIds objectAtIndex:i];
        Class class = [cellClasses objectAtIndex:i];
        [tableView registerClass:class forCellReuseIdentifier:reusedId];
        
        [self.holderViews addObject:tableView];
    }
    self.worryTableView = (UITableView *)[self.holderViews objectAtIndex:0];
    self.storyTableView = (UITableView *)[self.holderViews objectAtIndex:1];
}
@end
