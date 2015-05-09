//
//  ReplyDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/9.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//
#import "ReplyDetailController.h"
#import "AvatarView.h"
#import "UIView+DefaultView.h"
#import "Feed.pb.h"

@interface ReplyDetailController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UIButton *thanksButton;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *holderView;
@property (nonatomic,strong) UIView *miscHolderView;
@property (nonatomic,strong) PBFeed *pbFeed;
@property (nonatomic,strong) UIButton *commentButton;
@property (nonatomic,strong) UIButton *praiseButton;
@property (nonatomic,strong) UIButton *dispraiseButton;
@property (nonatomic,strong) UIButton *favoritesButton;

@end

@implementation ReplyDetailController
{
    CGFloat _holderViewHeight;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    [self hideTabBar];
    [self loadNavigationBar];
    [self loadTitleLabel];
    [self loadHolderView];
    [self loadMiscHolderView];
    [self loadTextView];
    
}

- (void)loadData
{
    [super loadData];
    _holderViewHeight = 44;
}

#pragma mark - Private methods

- (void)loadNavigationBar
{
    UIImage *shareImage = [UIImage imageNamed:@"story_detail_share"];
    UIImage *moreImage = [UIImage imageNamed:@"story_detail_more"];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:shareImage style:UIBarButtonItemStylePlain target:self action:@selector(clickShareButton)];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc]initWithImage:moreImage style:UIBarButtonItemStylePlain target:self action:@selector(clickMoreButton)];
    [self.navigationItem setRightBarButtonItems:@[moreItem,shareItem]];
}

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.view addSubview:self.titleLabel];
    self.titleLabel.text = self.pbFeed.title;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.height.equalTo(@(_holderViewHeight));
    }];
}

- (void)loadHolderView
{
    self.holderView = [[UIView alloc]init];
    [self.view addSubview:self.holderView];
    
    [self.holderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.height.equalTo(@(_holderViewHeight));
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(+2);
    }];
    
    [self loadAvatarView];
    [self loadThanksButton];
    
    UIView *topLine = [UIView createSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.holderView.mas_top);
    }];
    
    UIView *bottomLine = [UIView createSingleLineWithColor:kLayerColor borderWidth:kLayerBorderWidth superView:self.view];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.holderView.mas_bottom);
    }];
}

- (void)loadAvatarView
{
    self.avatarView = [[AvatarView alloc]initWithBorderWidth:1.0f];
    [self.holderView addSubview:self.avatarView];
    PBUser *pbUser = self.pbFeed.createUser;
    NSURL *url = [NSURL URLWithString:pbUser.avatar];
    [self.avatarView.imageView sd_setImageWithURL:url];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.holderView);
        make.centerY.equalTo(self.holderView);
        make.height.equalTo(self.holderView).with.multipliedBy(0.8);
        make.width.equalTo(self.holderView.mas_height).with.multipliedBy(0.8);
    }];
}

- (void)loadThanksButton
{
    self.thanksButton = [[UIButton alloc]init];
    [self.holderView addSubview:self.thanksButton];
    UIImage *image = [UIImage imageNamed:@"reply_thanks"];
    [self.thanksButton setImage:image forState:UIControlStateNormal];
    NSString *title = @"10";
    [self.thanksButton setTitle:title forState:UIControlStateNormal];
    [self.thanksButton setTitleColor:kLabelGrayColor forState:UIControlStateNormal];
    
    [self.thanksButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.holderView);
        make.centerY.equalTo(self.holderView);
    }];
}

- (void)loadTextView
{
    self.textView = [[UITextView alloc]init];
    [self.view addSubview:self.textView];
    //    self.textView.text = @"iOS系统自带的Switch开关是固定的大小,不能设置frame,这大大阻碍了我们的产品开发,所以小弟在闲暇时间写了这个自定义的Switch,不仅能够设置大小,也能设置左右开关颜色,文字,文字Font等等,对于系统的是否开关等Bool值属性也是应有尽有,可以说满足了我们对开关的所有需求,这是小弟第一次上传代码,希望大家多多支持";
    self.textView.text = self.pbFeed.text;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.miscHolderView.mas_top);
        make.top.equalTo(self.holderView.mas_bottom).with.offset(+2);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
    }];
}

- (void)loadMiscHolderView
{
    self.miscHolderView = [[UIView alloc]init];
    [self.view addSubview:self.miscHolderView];
    self.miscHolderView.layer.borderColor = [kLayerColor CGColor];
    self.miscHolderView.layer.borderWidth = kLayerBorderWidth;
    
    [self.miscHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@(_holderViewHeight));
    }];
    
    [self loadMiscButtons];
}

- (void)loadMiscButtons
{
    NSArray *imageNameArray = @[@"praise",@"dispraise",@"reply_favorites",@"reply_comments"];
    NSMutableArray *buttonArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < imageNameArray.count; i++) {
        NSString *imageName = [imageNameArray objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIButton *button = [[UIButton alloc]init];
        [self.miscHolderView addSubview:button];
        [button setImage:image forState:UIControlStateNormal];
        
        CGFloat scale = 0.125*(2*i+1);  //  1,3,5,7
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.miscHolderView);
            make.centerX.equalTo(self.miscHolderView.mas_right).with.multipliedBy(scale);
        }];
        
        [buttonArray addObject:button];
    }
    
    self.praiseButton = [buttonArray objectAtIndex:0];
    self.dispraiseButton = [buttonArray objectAtIndex:1];
    self.favoritesButton = [buttonArray objectAtIndex:2];
    self.commentButton = [buttonArray objectAtIndex:3];
    
    [self.praiseButton addTarget:self action:@selector(clickPraiseButton) forControlEvents:UIControlEventTouchUpInside];
    [self.dispraiseButton addTarget:self action:@selector(clickDisPraiseButton) forControlEvents:UIControlEventTouchUpInside];
    [self.favoritesButton addTarget:self action:@selector(clickFavoritesButton) forControlEvents:UIControlEventTouchUpInside];
    [self.commentButton addTarget:self action:@selector(clickCommentsButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Utils

- (void)clickShareButton
{
    //  TODO
}

- (void)clickMoreButton
{
    //  TODO
}

- (void)clickPraiseButton
{
    
}

- (void)clickDisPraiseButton
{
    
}

- (void)clickFavoritesButton
{
    
}

- (void)clickCommentsButton
{
    
}

@end
