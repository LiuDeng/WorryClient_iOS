//
//  WorryDetailController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/2.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "WorryDetailController.h"
#import "AvatarView.h"
#import "UIView+DefaultView.h"
#import "WorryAnswerCell.h"
#import "Feed.pb.h"

#define kInviteButtonTitle @"邀请"
#define kAnswerButtonTitle @"回答"
#define kBlessingButtonTitle @"祝福"
#define kWorryAnswerCell @"kWorryAnswerCell"

@interface WorryDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _holderViewHeight;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) AvatarView *avatarView;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) NSArray *buttonTitleArray;
@property (nonatomic,strong) NSArray *buttonImageNameArray;
@property (nonatomic,strong) PBFeed *pbFeed;

@property (nonatomic,strong) UIView *titleHolderView;
@property (nonatomic,strong) UIView *buttonHolderView;

@end

@implementation WorryDetailController

#pragma mark - Public methods

- (instancetype)initWithPBFeed:(PBFeed *)pbFeed
{
    self = [super init];
    if (self) {
        self.pbFeed = pbFeed;
    }
    return self;
}

#pragma mark - Private methods

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
    NSString *answerCount = @"22";
    self.title = [NSString stringWithFormat:@"共%@条回答",answerCount];
    [self loadTitleHolderView];
    [self loadButtonHolderView];
    [self loadTextView];
    [self loadTableView];

}

- (void)loadData
{
    [super loadData];
    self.buttonTitleArray = @[kInviteButtonTitle,kAnswerButtonTitle,kBlessingButtonTitle];
    self.buttonImageNameArray = @[@"worry_detail_invite_answer",@"worry_detail_answer",@"worry_detail_blessing"];
    _holderViewHeight = 44;
}

#pragma mark - Private methods
- (void)loadButtonHolderView
{
    self.buttonHolderView = [[UIView alloc]init];
    [self.view addSubview:self.buttonHolderView];
    self.buttonHolderView.layer.borderWidth = kLayerBorderWidth;
    self.buttonHolderView.layer.borderColor = [kLayerColor CGColor];
    
    [self.buttonHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.multipliedBy(0.4);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(_holderViewHeight));
    }];

    CGFloat count = self.buttonTitleArray.count;
    for (int i = 0 ; i<count; i++) {
        UIImage *image = [UIImage imageNamed:self.buttonImageNameArray[i]];
        NSString *title = self.buttonTitleArray[i];

        UIButton *button = [[UIButton alloc]init];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [self.buttonHolderView addSubview:button];
        [button setTitleColor:kLabelBlackColor forState:UIControlStateNormal];
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        button.titleEdgeInsets = edgeInsets;
        
        CGFloat xScale = (2*i+1)/count; //  (1,3,5)/3
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.buttonHolderView).with.dividedBy(count);
            make.height.equalTo(self.buttonHolderView).with.multipliedBy(0.9);
            make.centerY.equalTo(self.buttonHolderView);
            make.centerX.equalTo(self.view).with.multipliedBy(xScale);
        }];
    }
}

- (void)loadTitleHolderView
{
    self.titleHolderView = [[UIView alloc]init];
    [self.view addSubview:self.titleHolderView];
    self.titleHolderView.layer.borderWidth = kLayerBorderWidth;
    self.titleHolderView.layer.borderColor = [kLayerColor CGColor];

    [self.titleHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(_holderViewHeight));
    }];
    
    [self loadTitleLabel];
    [self loadAvatarView];
}

- (void)loadTitleLabel
{
    self.titleLabel = [[UILabel alloc]init];
    [self.titleHolderView addSubview:self.titleLabel];
    self.titleLabel.text = self.pbFeed.title;
//    self.titleLabel.textColor = kLabelBlackColor;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleHolderView);
        make.left.equalTo(self.titleHolderView.mas_right).with.multipliedBy(kLeftScale);
        make.width.equalTo(self.titleHolderView).with.multipliedBy(0.8);
        make.height.equalTo(self.titleHolderView);
    }];
}

- (void)loadAvatarView
{
//    self.avatarView = [[AvatarView alloc]initWithBorderWidth:kLayerBorderWidth];
    PBUser *pbUser = [[UserManager sharedInstance]pbUser];
    self.avatarView = [[AvatarView alloc]initWithPBUser:pbUser];
    [self.titleHolderView addSubview:self.avatarView];
//    UIImage *image = [UIImage imageNamed:@"avatar01"];
//    self.avatarView.image = image;
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleHolderView).with.multipliedBy(kRightScale);
        make.centerY.equalTo(self.titleHolderView);
        make.height.equalTo(self.titleHolderView).with.multipliedBy(0.9);
        make.width.equalTo(self.titleHolderView.mas_height).with.multipliedBy(0.9);
    }];
}

- (void)loadTextView
{
    self.textView = [[UITextView alloc]init];
    [self.view addSubview:self.textView];
//    self.textView.text = @"连续几次考试，成绩都在下游徘徊，明明有好好听课，明明有好好复习，可是为什么成绩老是提不上去？看到别人申请奖学金、出国、各种全能，我真的觉得自己一无是处。";
    self.textView.text = self.pbFeed.text;
    self.textView.textColor = kLabelBlackColor;
    self.textView.font = kMiddleLabelFont;
    
    [self.textView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).with.multipliedBy(kWidthScale);
        make.bottom.equalTo(self.buttonHolderView.mas_top);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(+2);
    }];
}

- (void)loadTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[WorryAnswerCell class] forCellReuseIdentifier:kWorryAnswerCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.buttonHolderView.mas_bottom);
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorryAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:kWorryAnswerCell forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:@"avatar01"];
    cell.avatarView.image = image;
    [cell.thanksButton setTitle:@"12" forState:UIControlStateNormal];
    cell.shortTextLabel.text = @"连续几次考试，成绩都在下游徘徊，明明有好好听课，明明有好好复习，可是为什么成绩老是提不上去？看到别人申请奖学金、出国、各种全能，我真的觉得自己一无是处。";
    cell.nickLabel.text = @"笑着流泪";
    return cell;
}

#pragma  mark - Utils

- (void)test
{
    JDDebug(@"test click");
}

@end
