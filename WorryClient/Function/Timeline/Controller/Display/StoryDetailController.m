//
//  StoryDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/1.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "StoryDetailController.h"
#import "AvatarView.h"
#import "THLabel.h"
#import "AppDelegate.h"
#import "FeedService.h"
#import "CommentListController.h"

const CGFloat strokeSize = 0.1f;

@interface StoryDetailController ()
{
    BOOL _isBGImageLightColor;
}

@property (nonatomic,strong) THLabel *titleLabel;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) AvatarView *creatUserAvatarView;
@property (nonatomic,strong) THLabel *nickLabel;
@property (nonatomic,strong) THLabel *dateLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIButton *editButton;
@property (nonatomic,strong) UIImageView *shareWeiboImageView;
@property (nonatomic,strong) UIImageView *shareWxTimelineImageView;
@property (nonatomic,strong) UIImageView *blessingImageView;
@property (nonatomic,strong) PBFeed *pbFeed;

@end

@implementation StoryDetailController

#pragma mark - Public methods

- (instancetype)initWithPBFeed:(PBFeed *)pbFeed
{
    self = [super init];
    if (self) {
        self.pbFeed = pbFeed;
    }
    return self;
}

#pragma mark - Default methods

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self customizeNavigationBar];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)loadView
{
    [super loadView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self loadNavigationBar];
    [self loadBGImageView];
    [self loadTitleLabel];
    [self loadDateLabel];
    [self loadCreatUserAvatarView];
    [self loadNickLabel];
    [self loadDateLabel];
    
    [self loadTextView];
//    [self loadShareWeiboImageView];
//    [self loadShareWxTimelineImageView];
//    [self loadBlessingImageView];
    
    [self loadEditButton];
}

#pragma mark - Private methods

- (void)loadNavigationBar
{
//    UIImage *moreImage = [UIImage imageNamed:@"story_detail_more"];
    UIImage *shareImage = [UIImage imageNamed:@"story_detail_share"];
    UIImage *favoriteImage = [UIImage imageNamed:@"omnibus_normal"];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:shareImage style:UIBarButtonItemStylePlain target:self action:@selector(clickShareButton)];
    UIBarButtonItem *favoriteItem = [[UIBarButtonItem alloc]initWithImage:favoriteImage style:UIBarButtonItemStylePlain target:self action:@selector(clickFavoriteButton)];
//    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc]initWithImage:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(clickMoreButton)];
    NSArray *barButtonArray = @[shareItem,favoriteItem];
    [self.navigationItem setRightBarButtonItems:barButtonArray];
    
    //  改变navigationBar的颜色
//    UIImage *navigationBGImage = [UIImage imageNamed:@"barbg64_white"];
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
//                                     NSForegroundColorAttributeName: [UIColor whiteColor],
//                                     };
//    [navigationBar setBackgroundImage:navigationBGImage forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setTitleTextAttributes:textAttributes];
//    [navigationBar setTintColor:OPAQUE_COLOR(0x87, 0x87, 0x87)];
    
}

- (void)loadBGImageView
{
    self.bgImageView = [[UIImageView alloc]init];
    [self.view addSubview:self.bgImageView];
    UIImage *image = [UIImage imageNamed:@"story_detail_image"];
    self.bgImageView.image = image;
    _isBGImageLightColor = [Utils isLightColorInImage:image];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(0.25);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadTitleLabel
{
    self.titleLabel = [[THLabel alloc]init];
    [self.bgImageView addSubview:self.titleLabel];
    self.titleLabel.text = self.pbFeed.title;
    self.titleLabel.font = [UIFont systemFontOfSize:24];
    self.titleLabel.strokeSize = strokeSize;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (_isBGImageLightColor) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.strokeColor = [UIColor blackColor];
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.strokeColor = [UIColor whiteColor];
    }
    

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImageView);
        make.bottom.equalTo(self.bgImageView.mas_centerY);
        make.width.equalTo(self.bgImageView).with.multipliedBy(0.5);
        make.height.equalTo(self.bgImageView).with.multipliedBy(0.25);
    }];
}

- (void)loadCreatUserAvatarView
{
    self.creatUserAvatarView = [[AvatarView alloc]initWithPBUser:self.pbFeed.createdUser];
    [self.bgImageView addSubview:self.creatUserAvatarView];
    
    [self.creatUserAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_centerX).with.multipliedBy(kRightScale);
        make.width.equalTo(self.bgImageView.mas_height).with.multipliedBy(0.22);
        make.top.equalTo(self.dateLabel.mas_bottom);
        make.height.equalTo(self.bgImageView).with.multipliedBy(0.22);
    }];
}

- (void)loadNickLabel
{
    self.nickLabel = [[THLabel alloc]init];
    [self.bgImageView addSubview:self.nickLabel];
    self.nickLabel.font = kLargeLabelFont;
    self.nickLabel.text = @"金鱼";
    self.nickLabel.strokeSize = strokeSize;
    if (_isBGImageLightColor) {
        self.nickLabel.textColor = [UIColor whiteColor];
        self.nickLabel.strokeColor = [UIColor blackColor];
    }else{
        self.nickLabel.textColor = [UIColor blackColor];
        self.nickLabel.strokeColor = [UIColor whiteColor];
    }
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.creatUserAvatarView);
        make.left.equalTo(self.bgImageView.mas_centerX).with.multipliedBy(1.05);
        make.right.equalTo(self.titleLabel);
    }];
}

- (void)loadDateLabel
{
    self.dateLabel = [[THLabel alloc]init];
    [self.bgImageView addSubview:self.dateLabel];
    self.dateLabel.text = @"2015.04.20";
    self.dateLabel.font = kMiddleLabelFont;
    self.dateLabel.strokeSize = strokeSize;
    if (_isBGImageLightColor) {
        self.dateLabel.textColor = [UIColor whiteColor];
        self.dateLabel.strokeColor = [UIColor blackColor];
    }else{
        self.dateLabel.textColor = [UIColor blackColor];
        self.dateLabel.strokeColor = [UIColor whiteColor];
    }
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_centerY);
        make.centerX.equalTo(self.titleLabel);
    }];
}

- (void)loadShareWeiboImageView
{
    UIImage *image = [UIImage imageNamed:@"story_detail_sina"];
    self.shareWeiboImageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:self.shareWeiboImageView];
    
    [self.shareWeiboImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_bottom).with.multipliedBy(0.9);
        make.width.equalTo(self.view.mas_height).with.multipliedBy(0.05);
        make.height.equalTo(self.view).with.multipliedBy(0.05);
        make.centerX.equalTo(self.view).with.multipliedBy(0.6);
    }];
}

- (void)loadShareWxTimelineImageView
{
    UIImage *image = [UIImage imageNamed:@"story_detail_weixin"];
    self.shareWxTimelineImageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:self.shareWxTimelineImageView];
    
    [self.shareWxTimelineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_bottom).with.multipliedBy(0.9);
        make.width.equalTo(self.view.mas_height).with.multipliedBy(0.05);
        make.height.equalTo(self.view).with.multipliedBy(0.05);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadBlessingImageView
{
    UIImage *image = [UIImage imageNamed:@"story_detail_blessing"];
    self.blessingImageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:self.blessingImageView];
    
    [self.blessingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_bottom).with.multipliedBy(0.9);
        make.width.equalTo(self.view.mas_height).with.multipliedBy(0.05);
        make.height.equalTo(self.view).with.multipliedBy(0.05);
        make.centerX.equalTo(self.view).with.multipliedBy(1.4);
    }];
}

- (void)loadTextView
{
    self.textView = [[UITextView alloc]init];
    [self.view addSubview:self.textView];
    self.textView.editable = NO;    //  TODO 若是作者，可以修改？
    self.textView.alwaysBounceVertical = YES;
    self.textView.contentSize = CGSizeMake(0, 665); //  只能垂直方向滚动，不能水平方向滚动，665这个数不是惟一的，貌似只要不太小就行，这个参照UIScrollView
    self.textView.font = kMiddleLabelFont;
    self.textView.textColor = kLabelBlackColor;
    self.textView.text = self.pbFeed.text;
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);//设置页边距
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bgImageView.mas_bottom);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)loadEditButton
{
    UIImage *image = [UIImage imageNamed:@"story_detail_edit"];
    self.editButton = [[UIButton alloc]init];
    [self.textView addSubview:self.editButton];
    [self.editButton setImage:image forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(clickEditBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).with.multipliedBy(1.8);
        make.centerY.equalTo(self.view).with.multipliedBy(1.8);
    }];
}
#pragma mark - Utils

- (void)clickMoreButton
{
    //  TODO
}
- (void)clickShareButton
{
    //  TODO
    [self showShareActionSheet:self.view];
}

- (void)clickFavoriteButton
{
    [[UserService sharedInstance]favoriteFeed:self.pbFeed.feedId block:^(NSError *error) {
        if (error) {
            POST_ERROR_MSG(@"收藏失败");
        }else {
            POST_SUCCESS_MSG(@"收藏成功");
        }
    }];
}

- (void)clickEditBtn
{
    CommentListController *vc = [[CommentListController alloc]initWithPBFeed:self.pbFeed];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
