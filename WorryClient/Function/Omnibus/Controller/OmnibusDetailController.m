//
//  OmnibusDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "OmnibusDetailController.h"
#import "TimelineCell.h"
#import "StoryCollectionViewCell.h"
#import "Topic.pb.h"
#import "Feed.pb.h"

#import "FeedService.h"
#import "MJRefresh.h"

#define kStoryTitle @"心事"
#define kWorryTitle @"心结"
#define kWorryCell  @"kWorryCell"
#define kStoryCell  @"kStoryCell"

@interface OmnibusDetailController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGFloat _countOfCollectionRow;
    CGFloat _countOfCollectionCol;
    CGFloat _collectionEdgePadding;
    CGFloat _collectionViewHeight;
}
/**
 *  storyHolderView has collectionView and recommendImageView.
 *  there used to have worryHolderView,but it only has tableView,so it is canceled.
 */

@property (nonatomic,strong) UIView *storyHolderView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIImageView *recommendImageView;
@property (nonatomic,strong) PBTopic *pbTopic;
@property (nonatomic,strong) NSMutableArray *storyFeeds;
@property (nonatomic,strong) NSMutableArray *worryFeeds;

@end

@implementation OmnibusDetailController

#pragma mark - Public methods

- (instancetype)initWithPBTopic:(PBTopic *)pbTopic
{
    self = [super init];
    if (self) {
        self.pbTopic = pbTopic;
    }
    return self;
}

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.pbTopic.title;
    [self.collectionView.header beginRefreshing];
}

- (void)loadView
{
    [super loadView];
    [self loadTableView];
    [self loadCollectionView];
    [self loadRecommendImageView];
}

- (void)loadData
{
    [super loadData];
    self.segmentTitles = @[kStoryTitle,kWorryTitle];
    
    _countOfCollectionRow = 2;
    _countOfCollectionCol = 3;
    _collectionEdgePadding = 1.0f;
    _collectionViewHeight = CGRectGetHeight(self.view.bounds)*0.6;  //  maybe a trouble
    /**
     *  the follow should be called before [super loadView]
     *  so,they are here.
     */
    self.holderViews = [[NSMutableArray alloc]init];
    [self loadTableView];
    self.storyHolderView = [[UIView alloc]init];
    [self.holderViews addObject:self.storyHolderView];
    [self.holderViews addObject:self.tableView];

}

#pragma  mark - Private methods

#pragma mark Worry holder view

- (void)loadTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TimelineCell class] forCellReuseIdentifier:kWorryCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;

self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf afterRefresh];
    }];
    
    self.tableView.footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf afterRefresh];
    }];
}

#pragma mark Story holder view

- (void)loadCollectionView
{
    CGFloat padding = _collectionEdgePadding;
    CGFloat col = _countOfCollectionCol;
    CGFloat row = _countOfCollectionRow;
    
    UICollectionViewFlowLayout *topicCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    topicCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(padding,padding,padding,padding);
    topicCollectionViewFlowLayout.minimumLineSpacing = 0;
    topicCollectionViewFlowLayout.minimumInteritemSpacing = 0;
    
    CGFloat itemSizeWidth = (CGRectGetWidth(self.view.frame) - padding * row)/row;
    CGFloat itemSizeHeight = (_collectionViewHeight - padding * (col + 1))/col;
    
    topicCollectionViewFlowLayout.itemSize = CGSizeMake(itemSizeWidth, itemSizeHeight);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:topicCollectionViewFlowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[StoryCollectionViewCell class]
                 forCellWithReuseIdentifier:kStoryCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.storyHolderView);
        make.bottom.equalTo(self.storyHolderView);
        make.width.equalTo(self.storyHolderView);
        make.height.equalTo(@(_collectionViewHeight));
    }];
    
    self.collectionView.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshingAction)];
    self.collectionView.footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshingAction)];
}

- (void)loadRecommendImageView
{
    self.recommendImageView = [[UIImageView alloc]init];
    [self.storyHolderView addSubview:self.recommendImageView];

    [self.recommendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.storyHolderView);
        make.top.equalTo(self.storyHolderView);
        make.width.equalTo(self.storyHolderView);
        make.height.equalTo(self.storyHolderView).with.offset(-_collectionViewHeight);
    }];
    
    self.recommendImageView.image = [UIImage imageNamed:@"image3.jpg"];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.worryFeeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PBFeed *pbFeed = self.worryFeeds[indexPath.row];
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:kWorryCell forIndexPath:indexPath];
    cell.titleLabel.text = pbFeed.title;
    cell.shortTextLabel.text = pbFeed.text;
    NSString *replyTitle = [NSString stringWithFormat:@"%lu",(unsigned long)pbFeed.comment.count];
    [cell.replyButton setTitle:replyTitle forState:UIControlStateNormal];
    NSString *blessingTitle = [NSString stringWithFormat:@"%lu",(unsigned long)pbFeed.blessing.count];
    [cell.blessingButton setTitle:blessingTitle forState:UIControlStateNormal];
    NSString *topicTitle = self.pbTopic.title;  //  TODO maybe cancel it.
    [cell.topicButton setTitle:topicTitle forState:UIControlStateNormal];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 167;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.storyFeeds.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PBFeed *pbFeed = self.storyFeeds[indexPath.row];
    
    StoryCollectionViewCell *storyCollectionViewCell = (StoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kStoryCell forIndexPath:indexPath];
    storyCollectionViewCell.titleLabel.text = pbFeed.title;
    storyCollectionViewCell.authorLabel.text = pbFeed.createdUser.nick;
    
    NSString *dateStr = [Utils dateStringCompareTo:pbFeed.createdAt];   //  TODO
    storyCollectionViewCell.dateLabel.text = dateStr;//@"金鱼女生喜欢上了一个男生，于是有了心事，只是一直都是独角戏。";
    
    return storyCollectionViewCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  TODO
}

#pragma mark - Utils

- (void)headerRefreshingAction
{
    __weak typeof(self) weakSelf = self;
    [[TopicService sharedInstance]getPBFeedsWithPBTopicId:weakSelf.pbTopic.topicId block:^(NSArray *pbObjects, NSError *error) {
        [weakSelf refreshWithPBObjects:pbObjects error:error];
    }];
}

- (void)footerRefreshingAction
{
    __weak typeof(self) weakSelf = self;
    [[TopicService sharedInstance]getMorePBFeedsWithPBTopicId:weakSelf.pbTopic.topicId block:^(NSArray *pbObjects, NSError *error) {
        [weakSelf refreshWithPBObjects:pbObjects error:error];
    }];
}

- (void)refreshWithPBObjects:(NSArray *)pbObjects error:(NSError *)error
{
    if (error) {
        //  failed in loading data from server and cache
        POST_ERROR_MSG(@"加载失败");
    }else{
        NSArray *pbFeeds = pbObjects;
        self.storyFeeds = [[NSMutableArray alloc]init];
        self.worryFeeds = [[NSMutableArray alloc]init];
        for (PBFeed *pbFeed in pbFeeds) {
            NSInteger type = pbFeed.type;
            switch (type) {
                case PBFeedTypeStory:
                    [self.storyFeeds addObject:pbFeed];
                    break;
                case PBFeedTypeWorry:
                    [self.worryFeeds addObject:pbFeed];
                    break;
                default:
                    break;
            }
        }
        [self.collectionView reloadData];
        [self.tableView reloadData];
    }
    [self afterRefresh];
}

- (void)afterRefresh
{
    if (self.collectionView.header.state != MJRefreshStateIdle) {
        [self.collectionView.header endRefreshing];
    }else if (self.collectionView.footer.state != MJRefreshStateIdle){
        [self.collectionView.footer endRefreshing];
    }
    
    if (self.tableView.header.state != MJRefreshStateIdle) {
        [self.tableView.header endRefreshing];
    }else if (self.tableView.footer.state != MJRefreshStateIdle){
        [self.tableView.footer endRefreshing];
    }
}

@end
