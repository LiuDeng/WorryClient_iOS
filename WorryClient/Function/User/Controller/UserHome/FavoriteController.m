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
#import "MJRefresh.h"
#import "FeedService.h"
#import "FeedService+Answer.h"

#define kWorryCell      @"worryCell"
#define kStoryCell      @"storyCell"
#define kWorryTitle     @"心结"
#define kStoryTitle     @"心事"

@interface FavoriteController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *storyTableView;
@property (nonatomic,strong) UITableView *worryTableView;
@property (nonatomic,strong) NSArray *storys;
@property (nonatomic,strong) NSArray *answers;
@property (nonatomic,strong) PBUser *pbUser;

@end

@implementation FavoriteController

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
    //  TODO 有可能出现一个加载成功，一个加载失败的情况，这样给用户的提示，就会出现重叠
    [self.storyTableView.header beginRefreshing];
    [self.worryTableView.header beginRefreshing];
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
    if (tableView == self.worryTableView) {
        return self.answers.count;
    }else{
        return self.storys.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.worryTableView) {
        PBAnswer *answer = self.answers[indexPath.row];
        FavoriteWorryCell *cell = [tableView dequeueReusableCellWithIdentifier:kWorryCell forIndexPath:indexPath];
        //  应该在answer里面存储forFeedTitle
//        cell.titleLabel.text = ;
        cell.answerLabel.text = answer.text;
        return cell;
    }else{
        PBFeed *pbFeed = self.storys[indexPath.row];
        FavoriteStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoryCell forIndexPath:indexPath];
        
        cell.titleLabel.text = pbFeed.title;
        cell.contentLabel.text = pbFeed.text;
//        cell.commentLabel.text = pbFeed.comment.count;
        
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
    
    __weak typeof(self) weakSelf = self;

    self.worryTableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [[FeedService sharedInstance]getUser:weakSelf.pbUser.userId favoriteAnswers:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                POST_ERROR_MSG(@"网络慢，请稍候再试");
            }else{
                weakSelf.answers = pbObjects;
            }
            [weakSelf afterRefresh];
        }];
    }];
    
    self.storyTableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [[FeedService sharedInstance]getUser:weakSelf.pbUser.userId favoriteFeeds:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                POST_ERROR_MSG(@"网络慢，请稍候再试");
            }else{
                weakSelf.storys = pbObjects;
            }
            [weakSelf afterRefresh];
        }];
    }];
}

#pragma mark - Utils

- (void)afterRefresh
{
    if (self.worryTableView.header.state != MJRefreshStateIdle) {
        [self.worryTableView.header endRefreshing];
        [self.worryTableView reloadData];
    }else if (self.storyTableView.header.state != MJRefreshStateIdle) {
        [self.storyTableView.header endRefreshing];
        [self.storyTableView reloadData];
    }
}
@end
