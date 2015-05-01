//
//  StoryDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/1.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "StoryDetailController.h"
#import "AvatarView.h"
#import "PlaceholderTextView.h"

@interface StoryDetailController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) AvatarView *creatUserAvatarView;
@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) PlaceholderTextView *textView;
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
    self.bgImageView.image = [UIImage imageNamed:@"image3.jpg"];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).with.multipliedBy(0.25);
        make.centerX.equalTo(self.view);
    }];
}

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.bgImageView addSubview:self.titleLabel];
    self.titleLabel.text = @"金鱼女生的暗恋";
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView).with.multipliedBy(kRightScale);
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
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.bgImageView.mas_height).with.multipliedBy(0.17);
        make.top.equalTo(self.dateLabel.mas_bottom);
        make.height.equalTo(self.bgImageView).with.multipliedBy(0.17);
    }];
}

- (void)loadNickLabel
{
    self.nickLabel = [[UILabel alloc]init];
    [self.bgImageView addSubview:self.nickLabel];
    self.nickLabel.font = kLargeLabelFont;
    self.nickLabel.text = @"金鱼";
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.creatUserAvatarView);
        make.left.equalTo(self.creatUserAvatarView.mas_right);
        make.right.equalTo(self.titleLabel);//  TODO
        make.height.equalTo(self.bgImageView).with.multipliedBy(0.045);
    }];
}

- (void)loadDateLabel
{
    self.dateLabel = [[UILabel alloc]init];
    [self.bgImageView addSubview:self.dateLabel];
    self.dateLabel.text = @"2015.04.20";
    self.dateLabel.font = kMiddleLabelFont;
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_centerY);
        make.right.equalTo(self.titleLabel);
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
