//
//  OmnibusController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/3/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "OmnibusController.h"
#import "TopicCollectionViewCell.h"
#import "OmnibusDetailController.h"
#import "CreateTopicController.h"
#import "TopicService.h"
#import "MJRefresh.h"
#import "RecommendationService.h"
#import "ImagePlayerView.h"
#import "StoryDetailController.h"
#import "WorryDetailController.h"
#import "FeedService.h"

#define kTopicCollectionViewCellId  @"kTopicCollectionViewCellId"

@interface OmnibusController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ImagePlayerViewDelegate>

@property (nonatomic,strong) NSArray *pbRecommendationArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *pbTopicArray;
@property (nonatomic,strong) ImagePlayerView *imagePlayerView;

@end

@implementation OmnibusController

#pragma mark - Default methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.header beginRefreshing];
//    [self hideTabBar];    // if is iphone4s
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self showTabBar];
}
- (void)loadView
{
    [super loadView];
//    [self addRightButtonWithImageName:@"plus" target:self action:@selector(clickPlusButton)];
    [self loadCollectionView];
    [self loadImagePlayerView];

}

- (void)loadData
{
    [super loadData];
//    self.isHideTabBar = NO;
//    [[RecommendationService sharedInstance]requireRecommendationWithBlock:^(NSError *error) {
//        if (error == nil) {
//            self.pbRecommendationArray = [[RecommendationService sharedInstance]pbRecommendationArray];
//            if (self.imagePlayerView) {
//                [self.imagePlayerView reloadData];
//            }
//        }
//    }];
    [[RecommendationService sharedInstance]getRecommendationsWithBlock:^(NSArray *pbObjects, NSError *error){
        if (error == nil){
         self.pbRecommendationArray = pbObjects;
         if (self.imagePlayerView) {
             [self.imagePlayerView reloadData];
         }
     }
    }];
}

#pragma mark - Private methods

- (void)loadImagePlayerView
{
    self.imagePlayerView = [[ImagePlayerView alloc]init];
    [self.view addSubview:self.imagePlayerView];
    self.imagePlayerView.imagePlayerViewDelegate = self;
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    [self.imagePlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.collectionView.mas_top);
    }];
}


- (void)loadCollectionView
{
    CGFloat edge = 3.0f;
    NSUInteger collectionRow = 3;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(edge, edge, edge, edge);
    flowLayout.minimumLineSpacing = edge;
    flowLayout.minimumInteritemSpacing = 0;

    CGFloat itemSizeWidthHeight = ( CGRectGetWidth(self.view.frame) - edge * (collectionRow + 1) ) / collectionRow;
    flowLayout.itemSize = CGSizeMake(itemSizeWidthHeight, itemSizeWidthHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TopicCollectionViewCell class]
                 forCellWithReuseIdentifier:kTopicCollectionViewCellId];

    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = OPAQUE_COLOR(0xee, 0xee, 0xee);
    __weak typeof(self) weakSelf = self;
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        [[TopicService sharedInstance]getPBTopicsWithBlock:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                //  failed in loading data from server and cache
                POST_ERROR_MSG(@"加载失败");
            }else{
                [weakSelf refreshPBTopicWith:pbObjects];
            }
        }];
    }];

    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        [[TopicService sharedInstance]getMorePBTopicsWithBlock:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                //  failed in loading data from server and cache
                POST_ERROR_MSG(@"加载失败");
            }else{
                [weakSelf refreshPBTopicWith:pbObjects];
            }
        }];
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_width);
    }];
}


#pragma mark - Utils

- (void)clickPlusButton
{
    CreateTopicController *vc = [[CreateTopicController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)refreshPBTopicWith:(NSArray *)pbObjects
{
    self.pbTopicArray = pbObjects;
    [self.collectionView reloadData];
    if (self.collectionView.header.state != MJRefreshHeaderStateIdle) {
        [self.collectionView.header endRefreshing];
    }else if (self.collectionView.footer.state != MJRefreshHeaderStateIdle){
        [self.collectionView.footer endRefreshing];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.pbTopicArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCollectionViewCell *cell = (TopicCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kTopicCollectionViewCellId forIndexPath:indexPath];
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    NSMutableArray *iconUrlArray = [[NSMutableArray alloc]init];
    for (PBTopic *pbTopic in self.pbTopicArray) {
        [titleArray addObject:pbTopic.title];
        [iconUrlArray addObject:[NSURL URLWithString:pbTopic.icon]];
    }
    cell.tittleLabel.text = titleArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:iconUrlArray[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PBTopic *pbTopic = self.pbTopicArray[indexPath.row];
    
    OmnibusDetailController *vc = [[OmnibusDetailController alloc]initWithPBTopic:pbTopic];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ImagePlayerViewDelegate

- (NSInteger)numberOfItems
{
    return self.pbRecommendationArray.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    PBRecommendation *pbRecommendation = [self.pbRecommendationArray objectAtIndex:index];
    NSString *feedId = pbRecommendation.feedId;
    PBFeed *pbFeed = [[FeedService sharedInstance]pbFeedWithFeedId:feedId];
    switch (pbFeed.type) {
        case PBFeedTypeStory:{
            StoryDetailController *vc = [[StoryDetailController alloc]initWithPBFeed:pbFeed];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case PBFeedTypeWorry:{
            WorryDetailController *vc = [[WorryDetailController alloc]initWithPBFeed:pbFeed];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    if (self.pbRecommendationArray.count == 0) {
        imageView.image = [UIImage imageNamed:@"image1"];   //  TODO
    }else{
        for (PBRecommendation *pbRecommendation in self.pbRecommendationArray) {
            NSString *imageUrl = pbRecommendation.image;
            NSURL *url = [NSURL URLWithString:imageUrl];
            [imageView sd_setImageWithURL:url];
        }
    }
}


@end
