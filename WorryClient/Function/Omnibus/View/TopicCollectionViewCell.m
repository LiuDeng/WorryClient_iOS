//
//  TopicCollectionViewCell.m
//  WorryClient
//
//  Created by 蔡少武 on 15/3/18.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "TopicCollectionViewCell.h"
#import "ViewDefault.h"
#import "UIView+Utils.h"

@implementation TopicCollectionViewCell
{
    UIView *contentHolderView;

    float kIconImageViewWidthHeight;
    float kContentHolderViewHeight;
    float kContentHolderViewWidth;
    float kIconBackgroundViewWidthHeight;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}
- (void)loadView
{
    self.contentView.backgroundColor = [UIColor grayColor];
    [self loadData];
    [self loadContentHolderView];
}
- (void)loadData
{


    kContentHolderViewHeight = CGRectGetHeight(self.contentView.frame) * 0.8;
    kContentHolderViewWidth = CGRectGetWidth(self.contentView.frame);
    kIconBackgroundViewWidthHeight = CGRectGetHeight(self.contentView.frame) * 0.5;
    kIconImageViewWidthHeight = kIconBackgroundViewWidthHeight;
}
- (void)loadContentHolderView
{
    contentHolderView = [[UIView alloc]init];
    [self.contentView addSubview:contentHolderView];
    
    [contentHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.height.equalTo(@(kContentHolderViewHeight));
        make.width.equalTo(@(kContentHolderViewWidth));
    }];
    [self loadIconBackgroundView];
    [self loadTittleLabel];
}
- (void)loadIconBackgroundView
{
    CGRect iconBackgroundViewFrame = CGRectMake(0, 0, kIconBackgroundViewWidthHeight, kIconBackgroundViewWidthHeight);
    self.iconBackgroundView = [[UIView alloc]initWithFrame:iconBackgroundViewFrame];
    self.iconBackgroundView.backgroundColor = [UIColor whiteColor];
    
    [contentHolderView addSubview:self.iconBackgroundView];
    [UIView setAsRound:self.iconBackgroundView];
    
    [self.iconBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentHolderView);
        make.centerX.equalTo(contentHolderView);
        make.height.equalTo(@(kIconBackgroundViewWidthHeight));
        make.width.equalTo(@(kIconBackgroundViewWidthHeight));
    }];
    
    [self loadIconImageView];
}
- (void)loadIconImageView
{
//    CGRect iconImageViewFrame = CGRectMake(0, 0, kIconImageViewWidth, kIconImageViewHeight);
    self.iconImageView = [[UIImageView alloc]init];

    [self.iconBackgroundView addSubview:self.iconImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.iconBackgroundView);
        make.center.equalTo(self.iconBackgroundView);
//        make.width.equalTo(@(kIconImageViewWidth));
//        make.height.equalTo(@(kIconImageViewHeight));
    }];
}
- (void)loadTittleLabel
{
    self.tittleLabel = [[UILabel alloc]init];
    [contentHolderView addSubview:self.tittleLabel];
    [self.tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconBackgroundView.mas_bottom).with.offset(+kVerticalPadding);
        make.centerX.equalTo(contentHolderView);
    }];
//    NSLog(@"%f",self.tittleLabel.frame.size.height);
}
@end
