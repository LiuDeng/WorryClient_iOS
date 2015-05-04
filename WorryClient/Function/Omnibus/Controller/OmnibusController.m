//
//  OmnibusController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/3/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "OmnibusController.h"
#import "TAPageControl.h"
#import "TopicCollectionViewCell.h"
#import "OmnibusDetailController.h"
#import "CreateTopicController.h"
#import "TopicManager.h"
#import "TopicService.h"

#define kTopicCollectionViewCellId  @"kTopicCollectionViewCellId"

@interface OmnibusController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) TAPageControl *scrollViewPageControl;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *scrollImageNameArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *collectionImageNameArray;
@property (nonatomic,strong) NSArray *collectionTittleArray;

@property (nonatomic,strong) NSArray *collectionImageUrlArray;
//@property (nonatomic,strong) PBTopic *pbTopic;

@end

@implementation OmnibusController

#pragma mark - Default methods
- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self addRightButtonWithImageName:@"plus" target:self action:@selector(clickPlusButton)];
    [self loadCollectionView];
    [self loadScrollView];

}

#pragma mark - Private methods
- (void)loadScrollView
{
    CGFloat kScrollViewHeight = CGRectGetHeight(self.view.frame)/4; //  if the height of collection view is changed,this should change too.
    CGFloat kScrollViewWidth = CGRectGetWidth(self.view.frame);
    NSUInteger scrollViewImageDataCount = self.scrollImageNameArray.count;
    
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(kScrollViewWidth * scrollViewImageDataCount, kScrollViewHeight);
    [self setupScrollViewImages];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.collectionView.mas_top);
    }];
    
    [self loadRecommendPageControl];
}
- (void)loadData
{
    [super loadData];
    self.scrollImageNameArray = @[@"image2.jpg",@"image1.jpg",@"image3.jpg"];
    self.collectionImageNameArray = @[@"love",@"test_first_page_selected",
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
    self.collectionTittleArray = @[@"爱情",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活",
                                        @"生活",@"生活",@"生活"];
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
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = OPAQUE_COLOR(0xee, 0xee, 0xee);
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_width);
    }];

}
- (void)loadRecommendPageControl
{
    self.scrollViewPageControl = [[TAPageControl alloc]init];
    [self.view addSubview:self.scrollViewPageControl];
    self.scrollViewPageControl.numberOfPages =  self.scrollImageNameArray.count;

    [self.scrollViewPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView).with.offset(-kVerticalPadding);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - Utils

- (void)setupScrollViewImages
{
    [self.scrollImageNameArray enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.scrollView).with.multipliedBy(idx*2+1);
            make.centerY.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
        }];
    }];
}

- (void)clickPlusButton
{
    CreateTopicController *vc = [[CreateTopicController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
        self.scrollViewPageControl.currentPage = pageIndex;
    }else{
        
    }
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionImageNameArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCollectionViewCell *cell = (TopicCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kTopicCollectionViewCellId forIndexPath:indexPath];
//    cell.tittleLabel.text = self.collectionTittleArray[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:self.collectionImageNameArray[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OmnibusDetailController *vc = [[OmnibusDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test
{
    __block NSArray *array;
    [[TopicService sharedInstance]requireNewTopicsWithBlock:^(NSError *error) {
        if (error == nil) {
            array = [[TopicManager sharedInstance]pbTopicArray];
//            PBTopic *pbTopic = [array objectAtIndex:0];
        }
    }];

    
}
@end
