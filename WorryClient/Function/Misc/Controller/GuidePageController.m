//
//  GuidePageController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/8.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "GuidePageController.h"
#import "AppDelegate.h"

@interface GuidePageController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *imageNameArray;
@property (nonatomic,strong) UIButton *signUpButton;
@property (nonatomic,strong) UIButton *logInButton;
@property (nonatomic,strong) UIButton *exploreButton;

@end

@implementation GuidePageController

#pragma mark - Default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)loadView
{
    [super loadView];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.view.backgroundColor = OPAQUE_COLOR(238, 247,246);
    [self loadScollView];
    [self loadLogInButton];
    [self loadSignUpButton];
}

- (void)loadData
{
    [super loadData];
    self.imageNameArray = @[@"guide_page_01",@"guide_page_02",@"guide_page_03"];
}

#pragma mark - Private methods

- (void)loadScollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    NSUInteger count = self.imageNameArray.count;
    CGFloat itemSizeWidth = CGRectGetWidth(self.view.frame) * count;
    CGFloat itemSizeHight = CGRectGetHeight(self.view.frame) - kStatusBarHeight;
    self.scrollView.contentSize = CGSizeMake(itemSizeWidth, itemSizeHight);
    
    [self setupScrollViewImages];
    [self loadPageControl];
    [self loadExploreButton];
}

- (void)loadPageControl
{
    self.pageControl = [[UIPageControl alloc]init];
    [self.scrollView addSubview:self.pageControl];
    self.pageControl.numberOfPages =  self.imageNameArray.count;
    self.pageControl.currentPageIndicatorTintColor = OPAQUE_COLOR(0x07, 0xaa, 0x48);
    self.pageControl.pageIndicatorTintColor = OPAQUE_COLOR(0xdd, 0xea, 0x1b);
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.multipliedBy(0.8);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadSignUpButton
{
    self.signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollView addSubview:self.signUpButton];
    [self.signUpButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.signUpButton setBackgroundColor:OPAQUE_COLOR(0x07, 0xaa, 0x48)];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logInButton.mas_bottom);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
    }];
}

- (void)loadLogInButton
{
    self.logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollView addSubview:self.logInButton];
    [self.logInButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.logInButton setBackgroundColor:OPAQUE_COLOR(0xdd, 0xea, 0x1b)];
    self 
    self.logInButton addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>
    
    [self.logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.multipliedBy(0.9);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
    }];
}

- (void)loadExploreButton
{
    self.exploreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.exploreButton];
    [self.exploreButton setTitle:@"体验一下" forState:UIControlStateNormal];
    self.exploreButton.hidden = YES;
    self.exploreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.exploreButton setTitleColor:kLabelGrayColor forState:UIControlStateNormal];
//    [UIView setRoundCorner:self.exploreButton];
    [self.exploreButton setRoundCorner];
    [self.exploreButton addTarget:self action:@selector(clickExploreButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.exploreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.multipliedBy(kRightScale);
        make.centerY.equalTo(self.pageControl);
    }];
    
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
        self.pageControl.currentPage = pageIndex;
        if(pageIndex == self.imageNameArray.count - 1){
            self.exploreButton.hidden = NO;
        }
    }
}

#pragma mark - Utils

- (void)setupScrollViewImages
{
    [self.imageNameArray enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.scrollView).with.multipliedBy(idx*2+1);
            make.centerY.equalTo(self.scrollView).with.multipliedBy(0.8);
        }];
    }];
}

- (void)clickExploreButton
{
    [[AppDelegate sharedInstance]showNormalHome];
}


@end
