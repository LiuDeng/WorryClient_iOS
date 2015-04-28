//
//  OmnibusController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/3/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "OmnibusController.h"
#import "Masonry.h"
#import "TAPageControl.h"
#import "ViewInfo.h"
#import "TopicCollectionViewCell.h"

#define kTopicCollectionViewCellId @"kTopicCollectionViewCellId"

@interface OmnibusController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    CGFloat kScrollViewHeight;
    CGFloat kScrollViewWidth;
    CGFloat kCollectionViewHeight;
    NSUInteger countOfTopicCollectionRow;
    NSUInteger countOfTopicCollectionCol;
    CGFloat topicCollectionEdgePadding;
}
@property (nonatomic,strong)TAPageControl *recommendScrollViewPageControl;
@property (nonatomic,strong)TAPageControl *topicCollectionPageControl;
@property (nonatomic,strong)UIScrollView *recommendScrollView;
@property (nonatomic,strong)NSArray *recommendScrollImageArray;
@property (nonatomic,strong)UICollectionView *topicCollectionView;
@property (nonatomic,strong)NSArray *topicCollectionImageNameArray;
@property (nonatomic,strong)NSArray *topicCollectionTittleArray;

@end

@implementation OmnibusController

#pragma mark - Default methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView
{
    [super loadView];
    [self loadData];
    [self loadScrollView];
    [self loadCollectionView];
}

#pragma mark - Private methods
- (void)loadScrollView
{
    NSUInteger scrollViewImageDataCount = self.recommendScrollImageArray.count;
    
    self.recommendScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.recommendScrollView];
    self.recommendScrollView.delegate = self;
    self.recommendScrollView.pagingEnabled = YES;
    self.recommendScrollView.showsVerticalScrollIndicator = NO;
    self.recommendScrollView.showsHorizontalScrollIndicator = NO;
    self.recommendScrollView.bounces = NO;
    self.recommendScrollView.contentSize = CGSizeMake(kScrollViewWidth * scrollViewImageDataCount, kScrollViewHeight);
    [self setupScrollViewImages];
    
    [self.recommendScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
//        make.height.equalTo(self.view).with.multipliedBy(0.25);
        make.height.equalTo(self.view).with.offset(-kCollectionViewHeight);
    }];
    
    [self loadRecommendPageControl];
}
- (void)loadData
{
    self.recommendScrollImageArray = @[@"image2.jpg",@"image1.jpg",@"image3.jpg"];
    kScrollViewHeight = CGRectGetHeight(self.view.frame)/4;
    kScrollViewWidth = CGRectGetWidth(self.view.frame);
    self.topicCollectionImageNameArray = @[@"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected",@"test_first_page_selected",
                                           @"test_first_page_selected"];
    self.topicCollectionTittleArray = @[@"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活"];
//    kCollectionViewHeight = CGRectGetHeight(self.view.frame) - kScrollViewHeight - kNavigationBarHeight -  kStatusBarHeight - kTabBarHeight;
//    kCollectionViewHeight = CGRectGetHeight(self.view.bounds)*0.75;
    kCollectionViewHeight = CGRectGetWidth(self.view.frame);
    countOfTopicCollectionRow = 3;
    countOfTopicCollectionCol = 3;
    topicCollectionEdgePadding = 3.0f;
}

- (void)loadCollectionView
{

    UICollectionViewFlowLayout *topicCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    topicCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(topicCollectionEdgePadding, topicCollectionEdgePadding, topicCollectionEdgePadding, topicCollectionEdgePadding);
    topicCollectionViewFlowLayout.minimumLineSpacing = topicCollectionEdgePadding;
    topicCollectionViewFlowLayout.minimumInteritemSpacing = 0;

    CGFloat itemSizeWidthHeight = (CGRectGetWidth(self.view.frame) - topicCollectionEdgePadding * (countOfTopicCollectionRow + 1))/countOfTopicCollectionRow;
//    CGFloat itemSizeHeight = (kCollectionViewHeight - topicCollectionEdgePadding * (countOfTopicCollectionCol + 1))/countOfTopicCollectionCol;
    topicCollectionViewFlowLayout.itemSize = CGSizeMake(itemSizeWidthHeight, itemSizeWidthHeight);
    topicCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
//    kCollectionViewHeight = itemSizeWidthHeight * countOfTopicCollectionRow;
    
    self.topicCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:topicCollectionViewFlowLayout];
    [self.view addSubview:self.topicCollectionView];
    self.topicCollectionView.delegate = self;
    self.topicCollectionView.dataSource = self;
    [self.topicCollectionView registerClass:[TopicCollectionViewCell class]
                 forCellWithReuseIdentifier:kTopicCollectionViewCellId];
    self.topicCollectionView.backgroundColor = [UIColor clearColor];
//    self.topicCollectionView.bounces = NO;
    self.topicCollectionView.showsHorizontalScrollIndicator = NO;
    self.topicCollectionView.showsVerticalScrollIndicator = NO;
//    self.topicCollectionView.pagingEnabled = YES;
//    NSInteger rows = self.topicCollectionImageNameArray.count/countOfTopicCollectionRow;
//    self.topicCollectionView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), itemSizeWidthHeight*rows);
    
    [self.topicCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.recommendScrollView.mas_bottom);
//        make.centerY.equalTo(self.view).with.multipliedBy(1.25);
        make.width.equalTo(self.view);
        make.height.equalTo(@(kCollectionViewHeight));
    }];

//    [self loadTopicCollectionPageControl];
}
- (void)loadRecommendPageControl
{
    self.recommendScrollViewPageControl = [[TAPageControl alloc]init];
    [self.view addSubview:self.recommendScrollViewPageControl];
    self.recommendScrollViewPageControl.numberOfPages =  self.recommendScrollImageArray.count;

    [self.recommendScrollViewPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.recommendScrollView).with.offset(-kVerticalPadding);
        make.centerX.equalTo(self.view);
    }];
}
- (void)loadTopicCollectionPageControl
{
    self.topicCollectionPageControl = [[TAPageControl alloc]init];
    [self.view addSubview:self.topicCollectionPageControl];
    self.topicCollectionPageControl.numberOfPages =  self.topicCollectionTittleArray.count/(countOfTopicCollectionRow * countOfTopicCollectionCol);
    
    [self.topicCollectionPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topicCollectionView).with.offset(-kVerticalPadding);
        make.centerX.equalTo(self.view);
    }];
}
#pragma mark - Utils

- (void)setupScrollViewImages
{
    [self.recommendScrollImageArray enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        [self.recommendScrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.recommendScrollView).with.multipliedBy(idx*2+1);
            make.centerY.equalTo(self.recommendScrollView);
            make.width.equalTo(self.recommendScrollView);
            make.height.equalTo(self.recommendScrollView);
        }];
    }];
}
#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == self.recommendScrollView) {
        NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
        self.recommendScrollViewPageControl.currentPage = pageIndex;
    }else if(scrollView == self.topicCollectionView){
        NSInteger pageIndex = (scrollView.contentOffset.x + topicCollectionEdgePadding *2) / CGRectGetWidth(scrollView.frame);
        self.topicCollectionPageControl.currentPage = pageIndex;
    }else{
        
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.topicCollectionImageNameArray.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCollectionViewCell *topicCollectionViewCell = (TopicCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kTopicCollectionViewCellId forIndexPath:indexPath];
    topicCollectionViewCell.tittleLabel.text = self.topicCollectionTittleArray[indexPath.row];
    topicCollectionViewCell.iconImageView.image = [UIImage imageNamed:self.topicCollectionImageNameArray[indexPath.row]];
    return topicCollectionViewCell;
}
@end
