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

#define kStoryTitle @"故事"
#define kWorryTitle @"心事"

@interface OmnibusDetailController ()<UIScrollViewDelegate>
{
    CGFloat _viewWidth;
    CGFloat _segmentedControlHeihtScale;
    CGFloat _scrollViewHeight;
}
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *worryHolderView;
@property (nonatomic,strong) UIView *storyHolderView;
@property (nonatomic,strong) NSArray *segmentedControlTitles;

@end

@implementation OmnibusDetailController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    [self hideTabBar];
    [self loadSegmentedControl];
    [self loadScrollView];
}

- (void)loadData
{
    [super loadData];
    _viewWidth = CGRectGetWidth(self.view.frame);
    self.segmentedControlTitles = @[kStoryTitle,kWorryTitle];
    _segmentedControlHeihtScale = 0.1;
    _scrollViewHeight = CGRectGetHeight(self.view.frame) * (1-_segmentedControlHeihtScale);
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
    CGFloat viewWidth = _viewWidth;
    CGFloat scrollViewHight = _scrollViewHeight;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, scrollViewHight) animated:YES];
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
    CGFloat viewWidth = _viewWidth;
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    NSUInteger arrayCount = self.segmentedControlTitles.count;
    self.scrollView.contentSize = CGSizeMake(_viewWidth * arrayCount, _scrollViewHeight);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(_viewWidth, 0, viewWidth, _scrollViewHeight) animated:NO];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.segmentedControl.mas_top);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(_scrollViewHeight));
        make.width.equalTo(self.view);
    }];
    
    [self loadWorryHolderView];
    [self loadStoryHolderView];
}

- (void)loadWorryHolderView
{
    NSUInteger index = [self.segmentedControlTitles indexOfObject:kWorryTitle];
    
    self.worryHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.worryHolderView];
    self.worryHolderView.backgroundColor = [UIColor greenColor];
   
    
    [self.worryHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.centerY.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
}

- (void)loadStoryHolderView
{
    NSUInteger index = [self.segmentedControlTitles indexOfObject:kStoryTitle];
    self.storyHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.storyHolderView];
    self.storyHolderView.backgroundColor = [UIColor yellowColor];
    
    
    [self.storyHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.centerY.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
}

#pragma mark - Utils

//- (void)segmentedControlValueDidChange
//{
//    
//}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}
@end
