//
//  OmnibusDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/29.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "OmnibusDetailController.h"
#import "HMSegmentedControl.h"
#import "UIColor+UIColorExt.h"
#import "TimelineCell.h"
#import "StoryCollectionViewCell.h"

#define kStoryTitle @"故事"
#define kWorryTitle @"心事"

#define kWorryCell  @"kWorryCell"
#define kStoryCell  @"kStoryCell"

@interface OmnibusDetailController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGFloat _viewWidth;
    CGFloat _segmentedControlHeihtScale;
    CGFloat _scrollViewHeight;
    CGFloat _countOfCollectionRow;
    CGFloat _countOfCollectionCol;
    CGFloat _collectionEdgePadding;
    CGFloat _collectionViewHeight;
}
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *worryHolderView;
@property (nonatomic,strong) UIView *storyHolderView;
@property (nonatomic,strong) NSArray *segmentedControlTitles;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIImageView *recommendStoryImageView;


@end

@implementation OmnibusDetailController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showTabBar];
}

- (void)loadView
{
    [super loadView];
    [self hideTabBar];
    [self.view layoutIfNeeded];
    [self loadSegmentedControl];
    [self loadScrollView];
    [self loadWorryHolderView];
    [self loadStoryHolderView];
}

- (void)loadData
{
    [super loadData];
    _viewWidth = CGRectGetWidth(self.view.frame);
    self.segmentedControlTitles = @[kStoryTitle,kWorryTitle];
    _segmentedControlHeihtScale = 0.1;
    _scrollViewHeight = CGRectGetHeight(self.view.frame) * (1-_segmentedControlHeihtScale);
    _countOfCollectionRow = 2;
    _countOfCollectionCol = 3;
    _collectionEdgePadding = 1.0f;
    _collectionViewHeight = CGRectGetHeight(self.view.bounds)*0.6;
}

#pragma  mark - Private methods

- (void)loadSegmentedControl
{
    self.segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:self.segmentedControlTitles];
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp;
    self.segmentedControl.selectionIndicatorColor = OPAQUE_COLOR(0x74, 0xC2, 0xA9);
    self.segmentedControl.selectionIndicatorHeight = 3.0f;
    self.segmentedControl.selectedTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:OPAQUE_COLOR(0x3A, 0xA7, 0x84), NSForegroundColorAttributeName,nil];
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        CGRect frame = weakSelf.scrollView.frame;
        frame.origin.x += frame.size.width * index;

        [weakSelf.scrollView scrollRectToVisible:frame animated:YES];
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(_segmentedControlHeihtScale);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadScrollView
{
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.directionalLockEnabled = YES;
    
    self.scrollView.backgroundColor = [UIColor greenColor];
    
    NSUInteger arrayCount = self.segmentedControlTitles.count;
    self.scrollView.contentSize = CGSizeMake(_viewWidth * arrayCount, _scrollViewHeight);
    self.scrollView.delegate = self;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.segmentedControl.mas_top);
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(1-_segmentedControlHeihtScale);
        make.width.equalTo(self.view);
    }];



}

- (void)loadWorryHolderView
{
    NSUInteger index = [self.segmentedControlTitles indexOfObject:kWorryTitle];
    
    self.worryHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.worryHolderView];
   
    
    [self.worryHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.centerY.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
    
    [self loadTableView];
}

- (void)loadStoryHolderView
{
    NSUInteger index = [self.segmentedControlTitles indexOfObject:kStoryTitle];
    self.storyHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.storyHolderView];
    
    [self.storyHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
    
    [self loadCollectionView];
    [self loadRecommendImageView];
}

#pragma mark Worry holder view

- (void)loadTableView
{
    //  self.view.bounds -> self.worryHolderView.bounds?
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.worryHolderView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TimelineCell class] forCellReuseIdentifier:kWorryCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.worryHolderView);
        make.center.equalTo(self.worryHolderView);
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
    
    CGFloat itemSizeWidth = (CGRectGetWidth(self.view.frame) - padding * (row))/row;
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
    self.recommendStoryImageView = [[UIImageView alloc]init];
    [self.storyHolderView addSubview:self.recommendStoryImageView];


    
    
    [self.recommendStoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.storyHolderView);
        make.top.equalTo(self.storyHolderView);
        make.width.equalTo(self.storyHolderView);
        make.height.equalTo(self.storyHolderView).with.offset(-_collectionViewHeight);
    }];
    

    self.recommendStoryImageView.image = [UIImage imageNamed:@"image3.jpg"];
}

#pragma mark - Utils




#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;   //  TODO
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:kWorryCell forIndexPath:indexPath];
    cell.titleLabel.text = @"title";
    cell.shortTextLabel.text = @"shoret jfladjfga=gasdfkasd";
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
    return CGRectGetHeight(self.worryHolderView.bounds)*0.012;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.topicCollectionImageNameArray.count;
    return 10;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoryCollectionViewCell *storyCollectionViewCell = (StoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kStoryCell forIndexPath:indexPath];
    storyCollectionViewCell.titleLabel.text = @"title ";
    storyCollectionViewCell.authorLabel.text = @"author";
    storyCollectionViewCell.dateLabel.text = @"xxxxxx";
    
    return storyCollectionViewCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  TODO
}

@end