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
#import "HMSegmentedControl.h"

#define kWorryCell      @"worryCell"
#define kStoryCell      @"storyCell"
#define kWorryTitle     @"心结"
#define kStoryTitle     @"心事"

@interface FavoriteController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGFloat _controlHeightScale;
    CGFloat _viewWidth;
    CGFloat _viewHeight;
    CGFloat _scrollViewHeigth;
}

@property (nonatomic,strong) UIView *storyHolderView;       //  心事
@property (nonatomic,strong) UIView *worryHolderView;       //  心结
@property (nonatomic,strong) UITableView *storyTableView;
@property (nonatomic,strong) UITableView *worryTableView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;
@property (nonatomic,strong) NSArray *titleArray;           //  the title of segmentedControl

@end

@implementation FavoriteController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    [self loadScrollView];
    [self loadSegmentedControl];
}

- (void)loadData
{
    [super loadData];
    _viewWidth = CGRectGetWidth(self.view.bounds);
    _viewHeight = CGRectGetHeight(self.view.bounds) - kStatusBarHeight - kNavigationBarHeight;
    _controlHeightScale = 0.1;
    _scrollViewHeigth = _viewHeight * (1 - _controlHeightScale);
    self.titleArray = @[kWorryTitle,kStoryTitle];
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

- (void)loadScrollView
{
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator  = NO;
    self.scrollView.bounces = NO;
    NSUInteger arrayCount = self.titleArray.count;
    self.scrollView.contentSize = CGSizeMake(_viewWidth * arrayCount, _scrollViewHeigth);
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(1-_controlHeightScale);
    }];
    
    [self loadStoryHolderView];
    [self loadWorryHolderView];
}
- (void)loadSegmentedControl
{
    self.segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:self.titleArray];
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorColor = kIndicatorColor;
    self.segmentedControl.selectionIndicatorHeight = kIndicatorHeight;
    self.segmentedControl.selectedTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:kControlTextColor,NSForegroundColorAttributeName, nil];
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        CGRect frame = weakSelf.scrollView.frame;
        frame.origin.x += frame.size.width * index;
        [weakSelf.scrollView scrollRectToVisible:frame animated:YES];
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(_controlHeightScale);
    }];
}

#pragma mark Story Holder View

- (void)loadStoryHolderView
{
    NSUInteger index = [self.titleArray indexOfObject:kStoryTitle];
    self.storyHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.storyHolderView];
    
    [self.storyHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.centerY.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
    
    [self loadStoryTableView];
}

- (void)loadStoryTableView
{
    self.storyTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.storyHolderView addSubview:self.storyTableView];
    [self.storyTableView registerClass:[FavoriteStoryCell class] forCellReuseIdentifier:kStoryCell];
    self.storyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.storyTableView.delegate = self;
    self.storyTableView.dataSource = self;
    
    [self.storyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.storyHolderView);
        make.center.equalTo(self.storyHolderView);
    }];
}

#pragma mark Worry Holder View

- (void)loadWorryHolderView
{
    NSUInteger index = [self.titleArray indexOfObject:kWorryTitle];
    self.worryHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.worryHolderView];
    
    [self.worryHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.centerY.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
    
    [self loadWorryTableView];
}

- (void)loadWorryTableView
{
    self.worryTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.worryHolderView addSubview:self.worryTableView];
    [self.worryTableView registerClass:[FavoriteWorryCell class] forCellReuseIdentifier:kWorryCell];
    self.worryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.worryTableView.delegate = self;
    self.worryTableView.dataSource = self;
    
    [self.worryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.worryHolderView);
        make.center.equalTo(self.worryHolderView);
    }];
    
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /**
     *  tableView is scrollView too.
     *  add the follow to avoid trouble.
     */
    if (scrollView == self.scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / pageWidth;
        [self.segmentedControl setSelectedSegmentIndex:page];
    }
}


@end
