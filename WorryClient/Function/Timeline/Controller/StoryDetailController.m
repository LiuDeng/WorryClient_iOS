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

const CGFloat strokeSize = 1.0f;

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
@property (nonatomic,strong) UIImageView *editImageView;
@property (nonatomic,strong) UIImageView *shareWeiboImageView;
@property (nonatomic,strong) UIImageView *shareWxTimelineImageView;
@property (nonatomic,strong) UIImageView *blessingImageView;


@end

@implementation StoryDetailController

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
    [self loadNavigationBar];
    [self loadBGImageView];
    [self loadTitleLabel];
    [self loadDateLabel];
    [self loadCreatUserAvatarView];
    [self loadNickLabel];
    [self loadDateLabel];
    
    [self loadTextView];
    [self loadShareWeiboImageView];
    [self loadShareWxTimelineImageView];
    [self loadBlessingImageView];
    
    [self loadEditImageView];
}

- (void)loadData
{
    [super loadData];
}

#pragma mark - Private methods

- (void)loadNavigationBar
{
    UIImage *moreImage = [UIImage imageNamed:@"story_detail_more"];
    UIImage *image = [UIImage imageNamed:@"story_detail_share"];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickShareButton)];
    UIBarButtonItem *favoriteItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickShareButton)];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc]initWithImage:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(clickMoreButton)];
    NSArray *barButtonArray = @[moreItem,shareItem,favoriteItem];
    [self.navigationItem setRightBarButtonItems:barButtonArray];
}

- (void)loadBGImageView
{
    self.bgImageView = [[UIImageView alloc]init];
    [self.view addSubview:self.bgImageView];
    UIImage *image = [UIImage imageNamed:@"image3.jpg"];
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
    self.titleLabel.text = @"金鱼女生的暗恋";
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
    self.creatUserAvatarView = [[AvatarView alloc]initWithBorderWidth:1.0f];
    [self.bgImageView addSubview:self.creatUserAvatarView];
    self.creatUserAvatarView.imageView.image = [UIImage imageNamed:@"avatar01"];
    
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
    UIImage *image = [UIImage imageNamed:@"story@3x"];
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
    UIImage *image = [UIImage imageNamed:@"story@3x"];
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
    UIImage *image = [UIImage imageNamed:@"story@3x"];
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
    self.textView.selectable = NO;
    self.textView.font = [UIFont systemFontOfSize:13];
    self.textView.text = @"工工工工工工工\n工工工工工工工\n工工工工工工工\n工工工工工工工\n工工工工工工工\n工工工工工工工\n";
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bgImageView.mas_bottom);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.height.equalTo(self.view).with.multipliedBy(0.5);
    }];
}

- (void)loadEditImageView
{
    UIImage *image = [UIImage imageNamed:@"story_detail_edit"];
    self.editImageView = [[UIImageView alloc]initWithImage:image];
    [self.textView addSubview:self.editImageView];
    self.editImageView.backgroundColor = [UIColor greenColor];
    
    [self.editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.textView).with.multipliedBy(1.8);
        make.centerY.equalTo(self.textView).with.multipliedBy(1.8);
        make.width.equalTo(self.textView.mas_height).with.multipliedBy(0.1);
        make.height.equalTo(self.textView).with.multipliedBy(0.1);
    }];
}
#pragma mark - Utils

- (void)clickMoreButton
{
    
}
- (void)clickShareButton
{
    
}


@end
