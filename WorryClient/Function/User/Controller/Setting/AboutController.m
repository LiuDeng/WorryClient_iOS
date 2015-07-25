//
//  AboutController.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/10.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "AboutController.h"
#import "WorryConfigManager.h"

#define kBasicCell      @"basicCell"

#define kMarkTitle      @"评分"
#define kIntroduceTitle @"功能介绍"
#define kFeedBackTitle  @"反馈"
#define kCheckTitle     @"检查新版本"

@interface AboutController ()

@property (nonatomic,strong) NSArray *sectionBasicItems;
@property (nonatomic,assign) int indexOfSection;
@property (nonatomic,assign) int sectionVersion;
@property (nonatomic,assign) int sectionBasic;
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UILabel *versionLabel;
@property (nonatomic,strong) UIView *versionView;

@end

@implementation AboutController

#pragma mark - Default methods

- (void)loadData
{
    [super loadData];
    self.sectionBasicItems = @[kMarkTitle,kFeedBackTitle,kIntroduceTitle,kCheckTitle];
    
    self.sectionVersion = self.indexOfSection++;
    self.sectionBasic = self.indexOfSection++;
}

- (void)loadTableView
{
    [super loadTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kBasicCell];
    
    [self loadVersionView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    num = self.sectionBasicItems.count;
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 167; //  TODO
}

//  self.tableView.tableHeaderView = self.versionView 这样写的话，versionView的位置不对，跟Masonry有关。
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.versionView;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBasicCell forIndexPath:indexPath];
    cell.textLabel.text = self.sectionBasicItems[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Private methods

- (void)loadVersionView
{
    self.versionView = [[UIView alloc]init];
    
    UIImage *image = [UIImage imageNamed:@"about_logo"];
    self.logoImageView = [[UIImageView alloc]initWithImage:image];
    [self.versionView addSubview:self.logoImageView];
    
    self.versionLabel = [[UILabel alloc]init];
    [self.versionView addSubview:self.versionLabel];
    self.versionLabel.textColor = [UIColor grayColor];
    self.versionLabel.font = kMiddleLabelFont;

    self.versionLabel.text = [NSString stringWithFormat:@"心事 %@",kWorryVersion];    //  TODO version不是这样获得的
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.versionView);
        make.centerY.equalTo(self.versionView).with.multipliedBy(0.8);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom);
        make.centerX.equalTo(self.logoImageView);
    }];
}

@end
