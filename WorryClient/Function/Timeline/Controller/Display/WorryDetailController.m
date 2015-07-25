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
#import "InviteAnswerController.h"
#import "AnswerController.h"
#import "SendBlessingController.h"
#import "AnswerDetailController.h"
#import "MJRefresh.h"
#import "FeedService+Answer.h"

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

@property (nonatomic,strong) UIButton *inviteAnswerBtn;
@property (nonatomic,strong) UIButton *answerBtn;
@property (nonatomic,strong) UIButton *blessingBtn;

@property (nonatomic,strong) NSArray *answers;

@end

@implementation WorryDetailController

#pragma mark - Default methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView.header beginRefreshing];
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

#pragma mark - Private methods

- (void)loadView
{
    [super loadView];
    int answerCount = 22;
    self.title = [NSString stringWithFormat:@"共%d条回答",answerCount];
    [self loadTitleHolderView];
    [self loadButtonHolderView];
    [self loadTextView];
    [self loadTableView];

}

- (void)loadData
{
    [super loadData];
//    self.buttonTitleArray = @[kInviteButtonTitle,kAnswerButtonTitle,kBlessingButtonTitle];
//    self.buttonImageNameArray = @[@"worry_detail_invite_answer",@"worry_detail_answer",@"worry_detail_blessing"];
    self.buttonTitleArray = @[kInviteButtonTitle,kAnswerButtonTitle];
    self.buttonImageNameArray = @[@"worry_detail_invite_answer",@"worry_detail_answer"];
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
    NSMutableArray *btns = [[NSMutableArray alloc]init];
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
//        CGFloat xScale = (2*i+3)/(count*2); //  (3,5)/4
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.buttonHolderView).with.dividedBy(count);
            make.height.equalTo(self.buttonHolderView).with.multipliedBy(0.9);
            make.centerY.equalTo(self.buttonHolderView);
            make.centerX.equalTo(self.view).with.multipliedBy(xScale);
        }];
        [btns addObject:button];
    }
    
    self.inviteAnswerBtn = btns[0];
    self.answerBtn = btns[1];
//    self.blessingBtn = btns[2];
    
    [self.inviteAnswerBtn addTarget:self action:@selector(clickInviteAnswerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.answerBtn addTarget:self action:@selector(clickAnswerBtn) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleHolderView);
        make.left.equalTo(self.titleHolderView.mas_right).with.multipliedBy(kLeftScale);
        make.width.equalTo(self.titleHolderView).with.multipliedBy(0.8);
        make.height.equalTo(self.titleHolderView);
    }];
}

- (void)loadAvatarView
{
    PBUser *pbUser = self.pbFeed.createdUser;
    self.avatarView = [[AvatarView alloc]initWithPBUser:pbUser];
    [self.titleHolderView addSubview:self.avatarView];
    
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
    
    __weak typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [[FeedService sharedInstance]getPBAnswersFromFeed:weakSelf.pbFeed.feedId block:^(NSArray *pbObjects, NSError *error) {
            if (error) {
                POST_ERROR_MSG(@"更新失败");
            }else{
                weakSelf.answers = pbObjects;
                [weakSelf.tableView reloadData];
            }
            [weakSelf afterRefresh];
        }];

    }];
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PBAnswer *pbAnswer = self.answers[indexPath.row];
    AnswerDetailController *vc = [[AnswerDetailController alloc]initWithPBAnswer:pbAnswer];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorryAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:kWorryAnswerCell forIndexPath:indexPath];

    PBAnswer *pbAnswer = self.answers[indexPath.row];
    
    PBUser *pbUser = pbAnswer.createdUser;
    NSString *thanksStr = [NSString stringWithFormat:@"%d",pbAnswer.thanksCount];
    
    [cell.avatarView setAvatarWithPBUser:pbUser];
    [cell.avatarView addTapGestureWithClickType:AvatarViewClickTypeUserInfo];
    [cell.thanksButton setTitle:thanksStr forState:UIControlStateNormal];
    NSString *text = [NSString stringWithFormat:@"%@\n\n",pbAnswer.text];   //  加2个"\n"的目的是，为了让文字置顶
    cell.shortTextLabel.text = text;
    cell.nickLabel.text = pbUser.nick;
    return cell;
}

#pragma  mark - Utils

- (void)test
{
    JDDebug(@"test click");
}

- (void)clickInviteAnswerBtn
{
    InviteAnswerController *vc = [[InviteAnswerController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickAnswerBtn
{
    AnswerController *vc = [[AnswerController alloc]initWithPBFeed:self.pbFeed];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBlessingBtn
{
    SendBlessingController *vc = [[SendBlessingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)afterRefresh
{
    if (self.tableView.header.state != MJRefreshStateIdle) {
        [self.tableView.header endRefreshing];
    }
}

@end
