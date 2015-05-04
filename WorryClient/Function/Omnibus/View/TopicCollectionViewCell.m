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

#pragma mark -Default methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat heightScale = 0.5;
    CGFloat verticalPadding = 5;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_bottom).with.multipliedBy(0.4);
        make.height.equalTo(self.contentView).with.multipliedBy(heightScale);
        make.width.equalTo(self.contentView.mas_height).with.multipliedBy(heightScale);
    }];
    [UIView setAsRound:self.imageView];
    
    [self.tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).with.offset(+verticalPadding);
        make.centerX.equalTo(self.contentView);
    }];
}

#pragma mark - Private methods

- (void)loadView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self loadImageView];
    [self loadTitleLabel];
}

- (void)loadImageView
{
    self.imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageView];
//    self.imageView.backgroundColor = [UIColor greenColor];
}
- (void)loadTitleLabel
{
    self.tittleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.tittleLabel];
    self.tittleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
