//
//  WSegmentController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/31.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "WSegmentController.h"
#import "HMSegmentedControl.h"

@interface WSegmentController ()<UIScrollViewDelegate>
{
    CGFloat _controlHeightScale;
    CGFloat _viewWidth;
    CGFloat _viewHeight;
    CGFloat _scrollViewHeigth;
}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;


@end

@implementation WSegmentController

#pragma mark - Public methods

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
    _controlHeightScale = 0.1;
    _viewHeight = CGRectGetHeight(self.view.bounds) - kNavigationBarHeight - kStatusBarHeight;
    _scrollViewHeigth =_viewHeight * (1 - _controlHeightScale);
    _viewWidth = CGRectGetWidth(self.view.bounds);
    
}

#pragma mark - Private methods

- (void)loadScrollView
{
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator  = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    NSUInteger arrayCount = self.segmentTitles.count;
    self.scrollView.contentSize = CGSizeMake(_viewWidth * arrayCount, _scrollViewHeigth);
    self.scrollView.scrollEnabled = NO; //  为了放在scrollView上的tableView能比较好滚动，设置scrollView不能滚动
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@(_scrollViewHeigth));
    }];
    
    [self loadHolderViews];
}

- (void)loadSegmentedControl
{
    self.segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:self.segmentTitles];
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

- (void)loadHolderViews
{
    for (int i=0; i<self.segmentTitles.count; i++) {
        UIView *holderView = (UIView *)[self.holderViews objectAtIndex:i];
        [self.scrollView addSubview:holderView];
        
        [holderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.scrollView);
            make.centerY.equalTo(self.scrollView);
            make.left.equalTo(self.scrollView).with.offset(+_viewWidth*i);
        }];
    }
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
