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
#import "FeedManager.h"
#import "FeedService.h"

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

#pragma mark - Utils

- (void)test
{
    [[FeedService sharedInstance]requireNewFeedsWithPBTopic:self.pbTopic block:^(NSError *error) {
//        if (error == nil) {
        
//        }
    }];
//    NSArray *pbFeedArray = [[FeedManager sharedInstance]pbFeedArrayWithPBTopic:self.pbTopic];
    
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;   //  TODO
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:kWorryCell forIndexPath:indexPath];
    cell.titleLabel.text = @"成绩提不上去，怎么办？";
    cell.shortTextLabel.text = @"连续几次考试，成绩一直不好啊，明明有认真听课啊";
    NSString *replyTitle = @"1";
    [cell.replyButton setTitle:replyTitle forState:UIControlStateNormal];
    NSString *blessingTitle = @"1";
    [cell.blessingButton setTitle:blessingTitle forState:UIControlStateNormal];
    NSString *topicTitle = @"爱情";
    [cell.topicButton setTitle:topicTitle forState:UIControlStateNormal];
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.view.bounds)*0.24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoryCollectionViewCell *storyCollectionViewCell = (StoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kStoryCell forIndexPath:indexPath];
    storyCollectionViewCell.titleLabel.text = @"金鱼女生的暗恋";
    storyCollectionViewCell.authorLabel.text = @"金鱼";
    storyCollectionViewCell.dateLabel.text = @"2015.04.20";//@"金鱼女生喜欢上了一个男生，于是有了心事，只是一直都是独角戏。";
    
    return storyCollectionViewCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  TODO
}

@end
