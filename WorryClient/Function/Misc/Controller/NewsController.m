//
//  NewsController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/26.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "NewsController.h"
#import "NewsCell.h"
#import "HMSegmentedControl.h"

#define kNOTECell   @"NOTECell"
#define kMSGCell    @"MSGCell"
#define kNOTETitle  @"通知"
#define kMSGTitle   @"私信"

@interface NewsController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGFloat _controlHeightScale;
    CGFloat _viewWidth;
    CGFloat _scrollViewHeigth;
}
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *NOTEHolderView;            //  通知
@property (nonatomic,strong) UIView *MSGHolderView;             //  私信
@property (nonatomic,strong) UITableView *NOTETableView;
@property (nonatomic,strong) UITableView *MSGTableView;
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;
@property (nonatomic,strong) NSArray *titleArray;               //  the title of segmentedControl

@end

@implementation NewsController

#pragma mark - Public methods

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
    [self loadScrollView];
    [self loadSegmentedControl];
}

- (void)loadData
{
    [super loadData];
    _controlHeightScale = 0.1;
    _scrollViewHeigth = CGRectGetHeight(self.view.bounds) * (1 - _controlHeightScale);
    _viewWidth = CGRectGetWidth(self.view.bounds);
    self.titleArray = @[kNOTETitle,kMSGTitle];
    
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
    NSUInteger arrayCount = self.titleArray.count;
    self.scrollView.contentSize = CGSizeMake(_viewWidth * arrayCount, _scrollViewHeigth);
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@(_scrollViewHeigth));
    }];
    
    [self loadNOTEHolderView];
    [self loadMSGHolderView];
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

#pragma mark NOTEHolderView
- (void)loadNOTEHolderView
{
    NSUInteger index = [self.titleArray indexOfObject:kNOTETitle];
    self.NOTEHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.NOTEHolderView];
    
    [self.NOTEHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.centerY.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
    
    [self loadNOTETableView];
}

- (void)loadNOTETableView
{
    self.NOTETableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.NOTEHolderView addSubview:self.NOTETableView];
    self.NOTETableView.delegate = self;
    self.NOTETableView.dataSource = self;
    [self.NOTETableView registerClass:[NewsCell class] forCellReuseIdentifier:kNOTECell];
    
    [self.NOTETableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.NOTEHolderView);
        make.center.equalTo(self.NOTEHolderView);
    }];
}

#pragma mark MSGHolderView

- (void)loadMSGHolderView
{
    NSUInteger index = [self.titleArray indexOfObject:kMSGTitle];
    self.MSGHolderView = [[UIView alloc]init];
    [self.scrollView addSubview:self.MSGHolderView];
    
    [self.MSGHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.centerY.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView).with.offset(+_viewWidth*index);
    }];
    
    [self loadMSGTableView];
}

- (void)loadMSGTableView
{
    self.MSGTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.MSGHolderView addSubview:self.MSGTableView];
    self.MSGTableView.delegate = self;
    self.MSGTableView.dataSource = self;
    [self.MSGTableView registerClass:[NewsCell class] forCellReuseIdentifier:kMSGCell];
    
    [self.MSGTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.MSGHolderView);
        make.center.equalTo(self.MSGHolderView);
    }];

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [self.segmentedControl setSelectedSegmentIndex:page];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.NOTETableView) {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kNOTECell forIndexPath:indexPath];
        
        cell.avatarView.imageView.image = [UIImage imageNamed:@"avatar01"];
        cell.nickLabel.text = @"用户";
        cell.timeLabel.text = @"十分钟前";
        cell.descriptionLabel.text = @"xx回答了你的问题";
        
        return cell;
    }else{
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kMSGCell forIndexPath:indexPath];
        
        cell.avatarView.imageView.image = [UIImage imageNamed:@"avatar01"];
        cell.nickLabel.text = @"用户";
        cell.timeLabel.text = @"十分钟前";
        cell.descriptionLabel.text = @"你好啊！";
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

@end
